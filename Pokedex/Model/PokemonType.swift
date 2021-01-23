//
//  PokemonType.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct PokemonType: Decodable {
    let slot: Int
    let type: NamedRefType
}
