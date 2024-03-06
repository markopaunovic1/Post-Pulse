//
//  ItemObjectModel.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-26.
//

import Foundation

class User {
    let nameOfUser: String
    let phoneNumber: String
    let emailAddress: String
    let employment: String
    
    init(nameOfUser: String, phoneNumber: String, emailAddress: String, employment: String) {
        self.nameOfUser = nameOfUser
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        self.employment = employment
    }
}

struct Item: Identifiable {
    let id = UUID()
    let user: User
    let name: String
    let image: [String]
    let description: String
    let price: String
    let category: TypeOfItem
    
    enum TypeOfItem {
        case fordon, elektronik, hushål, fritidHobby, instrument, kläder, bostad, personligt, jobb, övrigt
    }
}
