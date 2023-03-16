//
//  User.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/16/23.
//

import Foundation

struct User: Codable {
    var id: Int
    var username: String
    var email: String
    var firstName: String
    var lastName: String
    var gender: String
    var imageUrl: String
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case email
        case firstName
        case lastName
        case gender
        case imageUrl = "image"
        case token
    }
}
