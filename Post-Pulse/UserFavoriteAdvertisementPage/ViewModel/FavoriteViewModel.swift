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
    
    @Published var item : [Item2] = []

    
    init() {
        // Caches the users session until user is logged out
        self.userSession = Auth.auth().currentUser
    }
    
//    func updateFavoriteItems() {
//        guard let userID = userSession?.uid else {
//            print("No user is currently logged in")
//            return
//        }
//        
//        // Fetch items from "Ads" collection
//        fetchItems { items in
//            // Now you have the items, proceed to update the favoriteItems sub-collection for the user
//            let db = Firestore.firestore()
//            let userRef = db.collection("Users").document(userID)
//            let favoriteItemsRef = userRef.collection("favoriteItems")
//            
//            // Delete existing favorite items
//            favoriteItemsRef.getDocuments { (snapshot, error) in
//                if let error = error {
//                    print("Error getting documents: \(error)")
//                    return
//                }
//                
//                for document in snapshot!.documents {
//                    favoriteItemsRef.document(document.documentID).delete()
//                }
//                
//                // Add new favorite items
//                for item in items {
//                    do {
//                        let itemData = try Firestore.Encoder().encode(item)
//                        favoriteItemsRef.addDocument(data: itemData) { error in
//                            if let error = error {
//                                print("Error adding document: \(error)")
//                            } else {
//                                print("Document added with ID: \(item.id)")
//                            }
//                        }
//                    } catch {
//                        print("Error encoding item \(item.id): \(error)")
//                    }
//                }
//            }
//        }
//    }
    
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
        guard let itemId = userSession?.uid else {
            print("Item ID is missing")
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("Favourites").whereField("userId", isEqualTo: userSession?.uid ?? "")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                    return
                }
                
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let data = document.data()
                        if data["userId"] is String {
                            print("Item ID: \(data)")
                        }
                    }
                }
                
                db.collection("Ads").document()
                
                
            }
    }
}
