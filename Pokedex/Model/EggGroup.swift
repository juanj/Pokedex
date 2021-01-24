//
//  EggGroup.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

struct EggGroup: Decodable {
    let name: String
    let names: [Name]
}
