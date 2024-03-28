//
//  CategoryItemViewModel.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-26.
//

//import Foundation
//import FirebaseFirestore
//import Firebase


//class CategoryItemViewModel: ObservableObject {
//
//    var db = Firestore.firestore()
//
//    @Published var category = ["Inget", "Fordon", "Elektronik", "Hushåll", "Fritid & Hobby", "Kläder", "Bostad", "Personligt", "Jobb", "Övrigt"]
//
//    @Published var item : [Item2] = []
//
//    @Published var selectedCategory : CategoryOption? = nil
//
//    // Filtering ads
//    func filterSelected(category: CategoryOption) {
//        switch category {
//        case .vehicle, .electronic, .houseHold, .hobby, .clothes, .residence, .personal, .job, .overal, .nothing:
//            getAllAdsByCategory(category: category.rawValue)
//            break
//        }
//
//        self.selectedCategory = category
//    }
//
//    enum CategoryOption: String, CaseIterable {
//        case vehicle = "Fordon"
//        case electronic = "Elektronik"
//        case houseHold = "Hushåll"
//        case hobby = "Fritid & Hobby"
//        case clothes = "Kläder"
//        case residence = "Bostad"
//        case personal = "Personligt"
//        case job = "Jobb"
//        case overal = "Övrigt"
//        case nothing = "Inget"
//    }
//
//    func getAllAdsByCategory(category: String) {
//        db.collection("Ads").whereField("category", isEqualTo: category)
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    print("DEBUG: Error getting documents by date: \(error.localizedDescription)")
//                    return
//                }
//
//                guard let snapshot = snapshot else {
//                    print("DEBUG: No document found")
//                    return
//                }
//
//
//                    self.item = snapshot.documents.compactMap { itemDocument in
//                        let itemData = itemDocument.data()
//                        let userData = itemData["user"] as? [String: Any] ?? [:]
//
//                        print("successfully getting data: \(itemData)")
//
//                        return Item2(
//                            id: itemData["itemId"] as? String ?? "",
//                            itemName: itemData["itemName"] as? String ?? "",
//                            imageURL: itemData["imageURLs"] as? [String] ?? [],
//                            description: itemData["description"] as? String ?? "",
//                            price: itemData["price"] as? Int ?? 0,
//                            category: itemData["category"] as? String ?? "",
//                            dateCreated: itemData["dateCreated"] as? String ?? "",
//                            userId: userData["id"] as? String ?? "",
//                            fullname: userData["fullname"] as? String ?? "",
//                            email: userData["email"] as? String ?? "",
//                            employment: userData["employment"] as? String ?? "",
//                            phoneNumber: userData["phoneNumber"] as? String ?? ""
//                        )
//                    }
//                }
//            }
//
//}
