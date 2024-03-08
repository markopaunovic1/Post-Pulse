//
//  SearchBarViewModel.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-22.
//

import Foundation
import SwiftUI

class ItemViewModel: ObservableObject {
    
    // For filtering search
    @Published var allItems: [Item] = []
    
    // for user to search
    @Published var searchText: String = ""
    
    // Properties for Image Viewer
    @Published var showImageViewer = false
    @Published var selectedImageID: String = ""
    @Published var imageViewerOffset: CGSize = .zero
    @Published var backGroundOpacity:  Double = 1
    
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
    
    init() {
        self.allItems = showItem.items
    }
    
    // Filteres through what user is searching for
    var filteredItems: [Item] {
        guard !searchText.isEmpty else { return allItems }
        
        return allItems.filter { item in
            item.name.lowercased().contains(searchText.lowercased())
        }
    }
}

class showItem {
    
    static let items = [
    
        Item(user: User(nameOfUser: "John Doe",
                        phoneNumber: "123456789",
                        emailAddress: "john@example.com",
                        employment: "privat"),
             
             name: "PASSAT 2016",
             image: ["passat sido",
                     "passat rear",
                     "passat interior",
                     "passat profile",
                     "passat open hood",
                     "passat rim",
                     "passat seats"],
             description: "*KXG882*, ABS-bromsar, ACC/2-zons Klimatanläggning, Adaptiv farthållare, Airbag förare, Airbag passagerare fram, Airbag passagerare urkopplingsbar, Android Auto, Antisladd, Antispinn, Apple carplay, AUX-ingång, AWD, Backkamera, Bluetooth, CD/Radio, Dieselvärmare fjärrstyrd, Dragkrok utfällbar, Elbaklucka, Elhissar fram  Skinnklädsel, Sommardäck på 18 aluminiumfälgar, Start-/stoppfunktion, Svensksåld, Sätesvärme fram, Tonade rutor, USB-ingång",
                 price: "1000000",
             category: .fordon),
        
        Item(user: User(nameOfUser: "John Doe",
                        phoneNumber: "123456789",
                        emailAddress: "john@example.com",
                        employment: "Företag"),
             
             name: "Guitar",
             image: ["guitar side",
                     "guitar back",
                     "guitar close front",
                     "passat sido",
                     "passat rear"],
             description: "En väldigt fin gitarr som är 2 år gammal, spelat några gånger bara, utmärkt ljud",
                 price: "2299",
             category: .fritidHobby),
        
        Item(user: User(nameOfUser: "John Doe",
                        phoneNumber: "123456789",
                        emailAddress: "john@example.com",
                        employment: "Företag"),
             
             name: "Guitar",
             image: ["guitar side",
                     "guitar back",
                     "guitar close front"],
             description: "En väldigt fin gitarr som är 2 år gammal, spelat några gånger bara, utmärkt ljud",
                 price: "2299",
             category: .fritidHobby)
    ]
}
