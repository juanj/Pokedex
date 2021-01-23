//
//  PokemonStat.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct PokemonStat {
    // let stat: NamedRefType
    let effort: Int
    let baseStat: Int
}

extension PokemonStat: Decodable {
    enum CodingKeys: String, CodingKey {
        // case stat
        case effort
        case baseStat = "base_stat"
    }
}
