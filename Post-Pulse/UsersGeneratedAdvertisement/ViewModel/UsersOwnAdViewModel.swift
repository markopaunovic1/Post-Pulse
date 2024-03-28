//
//  UsersOwnAdViewModel.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-21.
//

import Foundation
import FirebaseFirestore
import Firebase

// self.item.removeAll()

class UserOwnAdViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User2?
    
    @Published var getUserOwnAd : [Item2] = []
    
    init() {
        // Caches the users session until user is logged out
        self.userSession = Auth.auth().currentUser
    }
    
    
    func fetchUsersOwnAd() {
        guard let userId = userSession?.uid else {
            print("User ID is missing")
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("Ads")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                    return
                }
                if let snapshot = snapshot {
                    var fetchedAd : [Item2] = []
                    
                    let dispatchGroup = DispatchGroup()
                    
                    for document in snapshot.documents {
                        guard let getUserId = document.data()["itemId"] as? String else {
                            continue
                        }
                        
                        dispatchGroup.enter()
                        
                        // Fetch users own ad based on itemId
                        db.collection("Ads").document(getUserId).getDocument { snapshotData, error in
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
                                fetchedAd.append(item)
                                print("Successfully fetched additional item \(item)")
                            } else {
                                print("DEBUG: Failed to find additional data for itemId: \(getUserId)")
                            }
                        }
                    }
                    dispatchGroup.notify(queue: .main) {
                        self.getUserOwnAd = fetchedAd
                    }
                }
            }
    }
    
    func deleteUserAd(itemId: String) {
        let db = Firestore.firestore()
        
        let adRef = db.collection("Ads").document(itemId)
        
        adRef.delete { error in
            if let error = error {
                print("DEBUG: Error deleting document: \(error.localizedDescription)")
            } else {
                print("Successfully deleted document")
                
                self.getUserOwnAd.removeAll { $0.id == itemId }
            }
        }
    }
}
