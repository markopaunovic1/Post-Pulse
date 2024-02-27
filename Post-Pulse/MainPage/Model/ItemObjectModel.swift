//
//  ItemObjectModel.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-26.
//

import Foundation


struct TheItems: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let image: [String]
    let price: String
    let typeOfItem: String
    
    }
