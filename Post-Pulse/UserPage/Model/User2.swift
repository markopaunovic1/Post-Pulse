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
}

extension User2 {
    static var MOCK_USER = User2(id: NSUUID().uuidString, fullname: "John Doe", email: "johndoe@gmail.com")
}
