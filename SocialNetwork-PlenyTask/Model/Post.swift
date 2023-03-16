//
//  Post.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/16/23.
//

import Foundation

struct Post: Identifiable, Codable {
    var id: Int
    var title: String
    var body: String
    var userId: Int
    var tags: [String]
    var reactions: Int
}
