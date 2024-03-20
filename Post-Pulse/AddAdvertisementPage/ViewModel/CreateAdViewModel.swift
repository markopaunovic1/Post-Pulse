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
    
    @Published var selectedImages : [UIImage] = []
    
    func uploadItem(itemId: String, itemName: String, price: String, description: String, userId: String, images: [UIImage]) {
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
                "imageURLs": imageURLs
            ]

            // Add document to Firestore
            db.collection("allItems").document(itemId).setData(itemData) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added successfully")
                }
            }
        }
    }
}
