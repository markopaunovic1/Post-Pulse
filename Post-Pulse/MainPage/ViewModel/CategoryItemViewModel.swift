//
//  CategoryItemViewModel.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-26.
//

import Foundation


class CategoryItemViewModel: ObservableObject {
    
    @Published var category = ["Fordon", "Elektronik", "Hushål", "Fritid & Hobby", "Kläder", "Bostad", "Personligt", "Jobb", "Övrigt"]
}
