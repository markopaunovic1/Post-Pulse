//
//  UsersOwnAdViewModel.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-21.
//

import Foundation
import FirebaseFirestore
import Firebase


extension ItemViewModel {
    
    
    func fetchOnlyUsersOwnAd(userId: String) {
        
        // Clear the existing items array
        self.item.removeAll()
        
        // Fetch items for the specified user
        db.collection("users").document(userId).collection("Items").getDocuments { itemSnapshot, error in
            if let error = error {
                // handle error
                print("Error getting items for user \(userId): \(error)")
                return
            }
            
            guard let itemDocuments = itemSnapshot?.documents else {
                print("No item documents found for user \(userId)")
                return
            }
            
            // Map item documents to Item2 objects
            let items = itemDocuments.map { itemDocument in
                let userData = itemDocument["user"] as? [String: Any] ?? [:]
                
                return Item2(
                    id: itemDocument["itemId"] as? String ?? "",
                    itemName: itemDocument["itemName"] as? String ?? "",
                    imageURL: itemDocument["imageURLs"] as? [String] ?? [],
                    description: itemDocument["description"] as? String ?? "",
                    price: itemDocument["price"] as? Int ?? 0,
                    category: itemDocument["category"] as? String ?? "",
                    dateCreated: itemDocument["dateCreated"] as? String ?? "",
                    userId: userData["id"] as? String ?? "",
                    fullname: userData["fullname"] as? String ?? "",
                    email: userData["email"] as? String ?? "",
                    employment: userData["employment"] as? String ?? "",
                    phoneNumber: userData["phoneNumber"] as? String ?? ""
                )
            }
            
            // Assign items to the item array
            self.item = items
        }
    }
}
