//
//  Post.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 23/01/2023.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let postId: Int
    let title: String
    let body: String
    
    enum CodingKeys : String, CodingKey {
        case userId
        case postId = "id"
        case title
        case body
    }
}
