//
//  PokemonSpeciesVariety.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

struct PokemonSpeciesVariety {
    let isDefault: Bool
    let pokemon: NamedRefType<Pokemon>
}

extension PokemonSpeciesVariety: Decodable {
    enum CodingKeys: String, CodingKey {
        case isDefault = "is_default"
        case pokemon
    }
}
