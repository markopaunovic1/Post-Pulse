//
//  CategoryItemViewModel.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-26.
//

import Foundation
import FirebaseFirestore
import Firebase


class CategoryItemViewModel: ObservableObject {
    
    var db = Firestore.firestore()
    
    @Published var category = ["Inget", "Fordon", "Elektronik", "Hushåll", "Fritid & Hobby", "Kläder", "Bostad", "Personligt", "Jobb", "Övrigt"]
    
    
    func getAllAdsByCategory(category: String) {
        db.collection("Ads").whereField("category", isEqualTo: category)
    }
}
