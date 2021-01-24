//
//  PokemonMove.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct PokemonMove {
    let move: NamedRefType<Move>
    let versionGroupDetails: [PokemonMoveVersion]
}

extension PokemonMove: Decodable {
    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}
