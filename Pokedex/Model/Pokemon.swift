//
//  Pokemon.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let abilities: [PokemonAbility]
    let moves: [PokemonMove]
    let sprites: PokemonSprites
    // let stats: [PokemonStat]
    let types: [PokemonType]
}
