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
                return Item2(
                    id: itemDocument["itemName"] as? String ?? "",
                    itemName: itemDocument["itemName"] as? String ?? "",
                    imageURL: itemDocument["imageURLs"] as? [String] ?? [],
                    description: itemDocument["description"] as? String ?? "",
                    price: itemDocument["price"] as? String ?? "",
                    category: Item2.TypeOfItem(rawValue: itemDocument["category"] as? String ?? "") ?? .ovrigt
                )
            }
            
            // Assign items to the item array
            self.item = items
        }
    }
}
