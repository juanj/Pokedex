//
//  PokemonStat.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct PokemonStat {
    let name: String
    let effort: Int
    let baseStat: Int
}

extension PokemonStat: Decodable {
    enum CodingKeys: String, CodingKey {
        case stat, effort, name
        case baseStat = "base_stat"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        effort = try container.decode(Int.self, forKey: .effort)
        baseStat = try container.decode(Int.self, forKey: .baseStat)

        let statContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .stat)
        name = try statContainer.decode(String.self, forKey: .name)
    }
}
