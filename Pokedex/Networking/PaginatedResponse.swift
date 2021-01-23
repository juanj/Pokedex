//
//  PaginatedResponse.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct PaginatedResponse<Type: Decodable>: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    var results: [Type]
}
