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
    
    // For user to search
    @Published var searchText: String = ""
    
    // Properties for Image Viewer
    @Published var showImageViewer = false
    @Published var selectedImageID: String = ""
    @Published var imageViewerOffset: CGSize = .zero
    @Published var backGroundOpacity:  Double = 1
    
    @Published var selectedOrder : SortOptions? = nil
    
    // For fetching user data
    var db = Firestore.firestore()
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
    
    enum SortOptions: String, CaseIterable {
        case noFilter = "Inget"
        case priceHigh = "Dyrast"
        case priceLow = "Billigast"
        case oldest = "Äldst"
        case newest = "Senaste"
    }
    
    func filterSelected(option: SortOptions) {
        switch option {
        case .priceHigh:
            getAllAdsSortedByPrice(descending: true)

            break
        case .priceLow:
            getAllAdsSortedByPrice(descending: false)
            break
            
        case .oldest:
            getAllAdsSortedByDate(descending: false)
            break
            
        case .newest:
            getAllAdsSortedByDate(descending: true)
            break
            
        case .noFilter:
            fetchItems()
        }
        
        self.selectedOrder = option
    }
    
    func getAllAdsSortedByDate(descending: Bool) {
        db.collection("Ads").order(by: "dateCreated", descending: descending)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Error getting documents by date: \(error.localizedDescription)")
                    return
                }
                
                if let snapshot = snapshot {
                    self.item = snapshot.documents.map { itemData in
                        let userData = itemData["user"] as? [String: Any] ?? [:]
                        
                        return Item2(
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
                    }
                }
            }
        }
    
    func getAllAdsSortedByPrice(descending: Bool) {
        db.collection("Ads").order(by: "price", descending: descending)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Error getting documents by price: \(error.localizedDescription)")
                    return
                }
                
                if let snapshot = snapshot {
                    self.item = snapshot.documents.map { itemData in
                        let userData = itemData["user"] as? [String: Any] ?? [:]
                        
                        return Item2(
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
                    }
                }
            }
    }
    
    // fetch all items from all users
    func fetchItems() {
        let db = Firestore.firestore()
        
        db.collection("Ads").getDocuments { snapshot, error in
            if let error = error {
                // handle error
                print("Error getting documents: \(error)")
                return
            }
            
            if let snapshot = snapshot {
                self.item = snapshot.documents.map { itemData in
                    let userData = itemData["user"] as? [String: Any] ?? [:]
                    
                    return Item2(
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
                }
            }
        }
    }
}
