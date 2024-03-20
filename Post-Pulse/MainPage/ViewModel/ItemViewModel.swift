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
    
    // Handles the image to close
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
    
    // Filteres through what user is searching for
    var filteredItems: [Item2] {
        guard !searchText.isEmpty else { return item }
        
        return item.filter { item in
            item.itemName.lowercased().contains(searchText.lowercased())
        }
    }
    
    // fetch all items from all users
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
                        imageURL: itemData["imageURLs"] as? [String] ?? [],
                        description: itemData["description"] as? String ?? "",
                        price: itemData["price"] as? String ?? "",
                        category: Item2.TypeOfItem(rawValue: itemData["category"] as? String ?? "") ?? .ovrigt
                    )
                }
            }
        }
    }
}
