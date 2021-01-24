//
//  PokemonAbility.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct PokemonAbility {
    let isHidden: Bool
    let slot: Int
    let ability: NamedRefType<Ability>
}

extension PokemonAbility: Decodable {
    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case slot, ability
    }
}
