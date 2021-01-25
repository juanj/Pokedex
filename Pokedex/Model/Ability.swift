//
//  Ability.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

struct Ability {
    let name: String
    let names: [Name]
    let effectEntries: [VerboseEffect]
}

extension Ability: Decodable {
    enum CodingKeys: String, CodingKey {
        case name, names
        case effectEntries = "effect_entries"
    }
}
