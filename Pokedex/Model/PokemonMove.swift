//
//  PokemonMove.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct PokemonMove: Decodable {
    let move: NamedRefType<Move>
}
