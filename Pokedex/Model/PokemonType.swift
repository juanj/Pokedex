//
//  PokemonType.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct PokemonType {
    let slot: Int
    let name: String
}

extension PokemonType: Decodable {
    enum CodingKeys: String, CodingKey {
        case slot, type, name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        slot = try container.decode(Int.self, forKey: .slot)
        let subContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .type)
        name = try subContainer.decode(String.self, forKey: .name)
    }
}
