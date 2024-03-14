//
//  CreateAdViewModel.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-12.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage


class CreateAdViewModel: ObservableObject {
    
    func addAdvertisement(itemName: String, price: String, description: String, userId: String) async throws {
        let db = Firestore.firestore()
        
        let data: [String: Any] = [
            "itemName": itemName,
            "price": price,
            "description": description
        ]
        
        db.collection("Users").document(userId).collection("Items").addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully")
            }
        }
    }
}
