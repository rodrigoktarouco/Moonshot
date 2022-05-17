//
//  UserInput.swift
//  Moonshot
//
//  Created by Rodrigo Tarouco on 11/05/22.
//

import Foundation

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}
