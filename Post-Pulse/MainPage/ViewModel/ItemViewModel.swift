//
//  SearchBarViewModel.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-22.
//

import Foundation
import FirebaseFirestore
import Firebase
import SwiftUI

class ItemViewModel: ObservableObject {
    
    // For filtering search
    //@Published var allItems: [Item] = []
    
    // For user to search
    @Published var searchText: String = ""
    
    // Properties for Image Viewer
    @Published var showImageViewer = false
    @Published var selectedImageID: String = ""
    @Published var imageViewerOffset: CGSize = .zero
    @Published var backGroundOpacity:  Double = 1
    
    // For fetching user data
    private var db = Firestore.firestore()
    @Published var user : [User2] = []
    @Published var item : [Item2] = []
    
    func onchange(value: CGSize) {
        imageViewerOffset = value
        
        let height = UIScreen.main.bounds.height / 2
        
        let progress = imageViewerOffset.height / height
        
        withAnimation(.default) {
            backGroundOpacity = Double(1 - (progress < 0 ? -progress : progress))
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation(.easeOut) {
            
            var translation = value.translation.height
            
            if translation < 200 {
                translation = -translation
                backGroundOpacity = 1
            }
            
            if translation < 200{
                imageViewerOffset = .zero
                
            } else {
                showImageViewer.toggle()
                imageViewerOffset = .zero
                backGroundOpacity = 1
            }
        }
    }
    
    //    init() {
    //        self.allItems = showItem.items
    //    }
    
    // Filteres through what user is searching for
    var filteredItems: [Item2] {
        guard !searchText.isEmpty else { return item }
        
        return item.filter { item in
            item.itemName.lowercased().contains(searchText.lowercased())
        }
    }
    
    func fetchItems() {
        
        let db = Firestore.firestore()
     
        db.collection("allItems").getDocuments { snapshot, error in
            
            if let error = error {
                // handle error
                print("Error getting documents: \(error)")
                return
            }
            
            if let snapshot = snapshot {
                
                self.item = snapshot.documents.map { itemData in
                    
                    return Item2(
                        id: UUID(),
                        itemName: itemData["itemName"] as? String ?? "",
                        image: itemData["imageURLs"] as? [String] ?? [],
                        description: itemData["description"] as? String ?? "",
                        price: itemData["price"] as? String ?? "",
                        category: Item2.TypeOfItem(rawValue: itemData["category"] as? String ?? "") ?? .ovrigt
                    )
                }
            }
        }
    }
//        db.collection("Users").getDocuments { snapshot, error in
//            // check for error
//            if let error = error {
//                // handle error
//                print("Error getting documents: \(error)")
//                return
//            }
//
//            // no errors
//            if let snapshot = snapshot {
//                // Update the property in the main thread
//                DispatchQueue.main.async {
//                    // Initialize an array to hold items
//                    var allItems: [Item2] = []
//
//                    // Iterate through each document in the "Users" collection
//                    for document in snapshot.documents {
//                        let userId = document.documentID
//
//                        // Get a reference to the "items" collection within the user document
//                        let itemsCollectionRef = self.db.collection("Users").document(userId).collection("Items")
//
//                        // Fetch documents from the "items" collection
//                        itemsCollectionRef.getDocuments { itemSnapshot, itemError in
//                            // Check for errors
//                            if let itemError = itemError {
//                                print("Error getting items: \(itemError)")
//                                return
//                            }
//
//                            // Iterate through each document in the "items" collection
//                            if let itemSnapshot = itemSnapshot {
//                                for itemDocument in itemSnapshot.documents {
//                                    // Extract item data
//                                    let itemId = itemDocument.documentID
//                                    let itemData = itemDocument.data()
//
//                                    // Create an Item2 instance from the fetched data
//                                    let newItem = Item2(
//                                        id: UUID(),
//                                        itemName: itemData["itemName"] as? String ?? "",
//                                        image: itemData["imageURLs"] as? [String] ?? [],
//                                        description: itemData["description"] as? String ?? "",
//                                        price: itemData["price"] as? String ?? "",
//                                        category: Item2.TypeOfItem(rawValue: itemData["category"] as? String ?? "") ?? .ovrigt
//                                    )
//
//                                    // Append the new item to the array
//                                    allItems.append(newItem)
//                                }
//                            }
//                        }
//                    }
//
//                    // Assign allItems to the property after all asynchronous operations complete
//                    self.item = allItems
//                }
//            }
//        }
//    }
}
