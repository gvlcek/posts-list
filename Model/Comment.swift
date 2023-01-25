//
//  Comment.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 23/01/2023.
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let commentId: Int
    let name: String
    let email: String
    let body: String
    
    enum CodingKeys : String, CodingKey {
        case postId
        case commentId = "id"
        case name
        case email
        case body
    }
}
