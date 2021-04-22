// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let contatoModel = try? newJSONDecoder().decode(ContatoModel.self, from: jsonData)

import Foundation

// MARK: - ContatoModelElement
struct ContatoModel: Decodable {
    let id: String?
    let createdAt: String?
    let name: String?
    let avatar: String?
    let company: String?
    let email: String?
    let phone: String?
    let website: String?
    let customNote: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "createdAt"
        case name = "name"
        case avatar = "avatar"
        case company =  "company"
        case email = "email"
        case phone = "phone"
        case website = "website"
        case customNote = "customNote"
    }
}

