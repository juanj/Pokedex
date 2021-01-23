//
//  PokemonResource.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct PokemonResource: ApiResource {
    typealias ModelType = Pokemon
    let id: Int
    var endpoint: String {
        "pokemon/\(id)"
    }
}
