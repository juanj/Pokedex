//
//  PokemonMoveVersion.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

struct PokemonMoveVersion {
    let levelLearnedAt: Int
}

extension PokemonMoveVersion: Decodable {
    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
    }
}
