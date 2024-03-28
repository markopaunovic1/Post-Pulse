//
//  FavoriteViewModel.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-21.
//

import Foundation
import FirebaseFirestore
import Firebase

class FavoriteViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User2?
    
    @Published var additionalData : [Item2] = []
    
    
    init() {
        // Caches the users session until user is logged out
        self.userSession = Auth.auth().currentUser
    }
    
    func addFavoriteItemToUser(userId: String, itemId: String) {
        
        guard ((userSession?.uid) != nil) else {
            print("User ID is missing")
            return
        }
        
        let db = Firestore.firestore()
        let favoriteRef = db.collection("Favourites").document()
        
        favoriteRef.setData([
            "itemId": itemId,
            "userId": userSession?.uid ?? ""
        ]) { error in
            if let error = error {
                print("DEBUG: Error adding item to favourites: \(error.localizedDescription)")
            } else {
                print("Successfully added item to favourites")
            }
        }
    }
    
    func fetchUsersFavoriteAd() {
        guard let userId = userSession?.uid else {
            print("User ID is missing")
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("Favourites")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                    return
                }
                if let snapshot = snapshot {
                    var fetchedItems : [Item2] = []
                    
                    let dispatchGroup = DispatchGroup()
                    
                    for document in snapshot.documents {
                        guard let itemId = document.data()["itemId"] as? String else {
                            continue
                        }
                        
                        dispatchGroup.enter()
                        
                        // Fetch additional data from Ads collection based on itemId
                        db.collection("Ads").document(itemId).getDocument { snapshotData, error in
                            defer {
                                dispatchGroup.leave()
                            }
                            
                            if let error = error {
                                print("Error fetching ad document: \(error.localizedDescription)")
                                return
                            }
                            
                            if let snapshotItem = snapshotData, let itemData = snapshotItem.data() {
                                
                                let userData = itemData["user"] as? [String: Any] ?? [:]
                                
                                let item = Item2(
                                    id: itemData["itemId"] as? String ?? "",
                                    itemName: itemData["itemName"] as? String ?? "",
                                    imageURL: itemData["imageURLs"] as? [String] ?? [],
                                    description: itemData["description"] as? String ?? "",
                                    price: itemData["price"] as? Int ?? 0,
                                    category: itemData["category"] as? String ?? "",
                                    dateCreated: itemData["dateCreated"] as? String ?? "",
                                    userId: userData["id"] as? String ?? "",
                                    fullname: userData["fullname"] as? String ?? "",
                                    email: userData["email"] as? String ?? "",
                                    employment: userData["employment"] as? String ?? "",
                                    phoneNumber: userData["phoneNumber"] as? String ?? ""
                                )
                                fetchedItems.append(item)
                                print("Successfully fetched additional item \(item)")
                            } else {
                                print("DEBUG: Failed to find additional data for itemId: \(itemId)")
                            }
                        }
                    }
                    dispatchGroup.notify(queue: .main) {
                        self.additionalData = fetchedItems
                    }
                }
            }
    }
    
    func deleteUserFavoriteAd(itemId: String) {
        let db = Firestore.firestore()
        
        guard let userId = userSession?.uid else {
            print("User ID is missing")
            return
        }
        
        db.collection("Favourites")
            .whereField("itemId", isEqualTo: itemId)
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Error getting documents: \(error.localizedDescription)")
                    return
                }
                guard let snapshot = snapshot else {
                    print("No document found")
                    return
                }
                for document in snapshot.documents {
                    let favoriteRef = db.collection("Favourites").document(document.documentID)
                    favoriteRef.delete { error in
                        
                        if let error = error {
                            print("DEBUG: Error deleteing favorite document: \(error.localizedDescription)")
                        } else {
                            print("Successfully deleted document")
                            
                            self.additionalData.removeAll() { $0.id == itemId }
                        }
                    }
                }
            }
    }
}

