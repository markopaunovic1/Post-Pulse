//
//  SearchBarViewModel.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-22.
//

import Foundation

class ItemViewModel: ObservableObject {
    
    @Published var allItems = [TheItems]()
    @Published var searchText: String = ""
    
    let items = [
    
        TheItems(name: "PASSAT 2016",
                 image: ["passat sido", "passat rear", "passat interior", "passat profile"],
                 price: "1000000",
                 typeOfItem: .fordon),
        
        TheItems(name: "Guitar",
                 image: ["guitar side", "guitar back", "guitar close front"],
                 price: "2299",
                 typeOfItem: .fritidHobby),
        TheItems(name: "Guitar",
                 image: ["guitar side", "guitar back", "guitar close front"],
                 price: "2299",
                 typeOfItem: .fritidHobby)
    ]
    
    var filteredItems: [TheItems] {
        guard !searchText.isEmpty else { return allItems }
        
        return allItems.filter { item in
            item.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    
    
    
}
