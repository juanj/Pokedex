//
//  Generation.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

struct Generation: Decodable {
    let name: String
    let names: [Name]
}
