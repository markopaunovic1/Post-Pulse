//
//  User.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-11.
//

import Foundation

struct User2: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    let employment: String
    let phoneNumber: String
}

struct Item2: Identifiable, Codable, Hashable {
    let id: String
    let itemName: String
    let imageURL: [String]
    let description: String
    let price: Int
    let category: String
    let dateCreated: String
    let userId: String
    let fullname: String
    let email: String
    let employment: String
    let phoneNumber: String
    
}

extension User2 {
    static var MOCK_USER = User2(id: NSUUID().uuidString, fullname: "John Doe", email: "johndoe@gmail.com", employment: "privat", phoneNumber: "0766666666")
}
