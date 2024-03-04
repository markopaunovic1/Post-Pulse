//
//  SearchBarViewModel.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-22.
//

import Foundation

class ItemViewModel: ObservableObject {
    
    @Published var allItems: [Item] = []
    @Published var searchText: String = ""
    
    init() {
        self.allItems = showItem.items
    }
    
    var filteredItems: [Item] {
        guard !searchText.isEmpty else { return allItems }
        
        return allItems.filter { item in
            item.name.lowercased().contains(searchText.lowercased())
        }
    }
}

struct showItem {
    
    static let items = [
    
        Item(name: "PASSAT 2016",
             image: ["passat sido",
                     "passat rear",
                     "passat interior",
                     "passat profile"],
             description: "En fin Passat 2016 modell med 190hk",
                 price: "1000000",
             category: .fordon),
        
        Item(name: "Guitar",
             image: ["guitar side",
                     "guitar back",
                     "guitar close front"],
             description: "En väldigt fin gitarr som är 2 år gammal, spelat några gånger bara och är inte längre behov av den",
                 price: "2299",
             category: .fritidHobby),
        
        Item(name: "Guitar",
             image: ["guitar side",
                     "guitar back",
                     "guitar close front"],
             description: "En väldigt fin gitarr som är 2 år gammal, spelat några gånger bara och är inte längre behov av den",
                 price: "2299",
             category: .fritidHobby)
    ]
}
