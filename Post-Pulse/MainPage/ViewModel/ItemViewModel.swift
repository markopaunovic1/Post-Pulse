
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
    
    // Properties for filter and sorting ads
    @Published var selectedOrder : SortOptions? = nil
    
    // For fetching user data
    var db = Firestore.firestore()
    @Published var user : [User] = []
    @Published var item : [Item] = []
    
    @Published var category = ["Inget", "Fordon", "Elektronik", "Hushåll", "Fritid & Hobby", "Kläder", "Bostad", "Personligt", "Jobb", "Övrigt"]
    
    @Published var selectedCategory : CategoryOption? = nil
    
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
    var filteredItems: [Item] {
        guard !searchText.isEmpty else { return item }
        
        return item.filter { item in
            item.itemName.lowercased().contains(searchText.lowercased())
        }
    }
    
    // Sorting ads
    func sortSelected(option: SortOptions) {
        switch option {
        case .priceHigh:
            item.sort { $0.price > $1.price }
            
            break
        case .priceLow:
            item.sort { $0.price < $1.price }
            break
            
        case .oldest:
            item.sort { $0.dateCreated < $1.dateCreated }
            break
            
        case .newest:
            item.sort { $0.dateCreated > $1.dateCreated }
            break
            
        case .noFilter:
            fetchItems()
        }
        
        selectedOrder = option
    }
    
    enum SortOptions: String, CaseIterable {
        case noFilter = "Nollställ"
        case priceHigh = "Dyrast"
        case priceLow = "Billigast"
        case oldest = "Äldst"
        case newest = "Senaste"
    }
    
    func filterSelected(category: CategoryOption) {
        switch category {
        case .vehicle, .electronic, .houseHold, .hobby, .clothes, .residence, .personal, .job, .overal, .nothing:
            break
        }
        self.selectedCategory = category
    }
    
    enum CategoryOption: String, CaseIterable {
        case vehicle = "Fordon"
        case electronic = "Elektronik"
        case houseHold = "Hushåll"
        case hobby = "Fritid & Hobby"
        case clothes = "Kläder"
        case residence = "Bostad"
        case personal = "Personligt"
        case job = "Jobb"
        case overal = "Övrigt"
        case nothing = "Inget"
    }
    
    
    func getAllAdsByCategory(forCategory category: String) {
        db.collection("Ads").whereField("category", isEqualTo: category)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Error getting documents by date: \(error.localizedDescription)")
                    return
                }
                
                guard let snapshot = snapshot else {
                    print("DEBUG: No document found")
                    return
                }
                
                
                self.item = snapshot.documents.compactMap { itemDocument in
                    let itemData = itemDocument.data()
                    let userData = itemData["user"] as? [String: Any] ?? [:]
                    
                    print("successfully getting data: \(itemData)")
                    
                    return Item(
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
                    
                    return Item(
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
