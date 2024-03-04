//
//  ItemObjectModel.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-26.
//

import Foundation


struct Item: Identifiable, Hashable, Equatable {
    let id = UUID()
    let name: String
    let image: [String]
    let description: String
    let price: String
    let category: TypeOfItem
    
    enum TypeOfItem {
        case fordon, elektronik, hushål, fritidHobby, instrument, kläder, bostad, personligt, jobb, övrigt
    }
}
