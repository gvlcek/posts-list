//
//  Constants.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 23/01/2023.
//

import Foundation

struct Constants {
    static let coreDataEntityFavorite: String = "Favorite"
    static let coreDataEntityPost: String = "PostEntity"
    
    struct URL_SERVICES {
        static let posts = "https://jsonplaceholder.typicode.com/posts"
        static let users = "https://jsonplaceholder.typicode.com/users?id="
        static let comments = "https://jsonplaceholder.typicode.com/comments?postId="
    }
}
