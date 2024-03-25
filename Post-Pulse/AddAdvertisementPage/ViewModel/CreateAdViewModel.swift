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
import SwiftUI

class CreateAdViewModel: ObservableObject {
    
    @ObservedObject var authViewModel: AuthViewModel
        
        init(authViewModel: AuthViewModel) {
            self.authViewModel = authViewModel
        }
    
    @Published var selectedImages : [UIImage] = []
    
    @MainActor func uploadItem(itemId: String, itemName: String, price: Int, description: String, userId: String, images: [UIImage], category: String, dateCreated: Date) {
        
        guard let currentUser = authViewModel.currentUser else {
            print("DEBUG: No authenticated user found")
            return
        }
        
        let db = Firestore.firestore()
        let dispatchGroup = DispatchGroup()

        var imageURLs = [String]()

        // Enter dispatch group for each image upload
        for image in images {
            dispatchGroup.enter()

            let imageData = image.jpegData(compressionQuality: 1)

            guard let imageData = imageData else {
                dispatchGroup.leave()
                continue
            }

            let imageName = UUID().uuidString
            let imagePath = "images/\(imageName).jpg"
            let storageRef = Storage.storage().reference(withPath: imagePath)

            // Upload image data
            storageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    print("Error uploading image: \(error)")
                    dispatchGroup.leave()
                    return
                }

                // Once uploaded, get download URL
                storageRef.downloadURL { url, error in
                    defer {
                        dispatchGroup.leave()
                    }

                    if let error = error {
                        print("Error getting download URL: \(error)")
                        return
                    }

                    if let downloadURL = url {
                        imageURLs.append(downloadURL.absoluteString)
                    }
                }
            }
        }

        // Notify when all images are uploaded and URLs are retrieved
        dispatchGroup.notify(queue: .main) {
                    
            
            // Add item data to Firestore with image URLs
            let itemData: [String: Any] = [
                "userId": userId,
                "itemId" : itemId,
                "itemName": itemName,
                "price": price,
                "description": description,
                "imageURLs": imageURLs,
                "category": category,
                "dateCreated": dateCreated,
                "user": [
                    "id": currentUser.id,
                    "fullname": currentUser.fullname,
                    "email": currentUser.email,
                    "employment": currentUser.employment,
                    "phoneNumber": currentUser.phoneNumber
                ]
            ]

            // Add document to Ads Firestore
            db.collection("Ads").document(itemId).setData(itemData) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added successfully")
                }
            }
        }
    }
}
