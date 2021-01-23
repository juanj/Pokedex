//
//  PokemonCellViewModel.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct PokemonCellViewModel {
    let pokemon: Pokemon
}

extension PokemonCellViewModel {
    var number: String {
        String(format: "#%03d", pokemon.id)
    }

    var name: String {
        pokemon.name
    }

    var types: [String] {
        pokemon.types.map(\.name)
    }
}
