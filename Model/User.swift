//
//  User.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 23/01/2023.
//

import Foundation

struct User: Codable {
    let userId: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
    enum CodingKeys : String, CodingKey {
        case userId = "id"
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipCode: String?
    let geo: Geolocalization
}

struct Geolocalization: Codable {
    let latitude: String
    let longitude: String
    
    enum CodingKeys : String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}
