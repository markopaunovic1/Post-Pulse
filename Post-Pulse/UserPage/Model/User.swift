
import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    let employment: String
    let phoneNumber: String
}

struct Item: Identifiable, Codable, Hashable {
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

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "John Doe", email: "johndoe@gmail.com", employment: "privat", phoneNumber: "0766666666")
}
