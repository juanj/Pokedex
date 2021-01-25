//
//  PokemonCaptureCellViewModel.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

struct PokemonCaptureCellViewModel {
    let species: PokemonSpecies
    let theme: Theme?
}

extension PokemonCaptureCellViewModel {
    var habitat: String? {
        species.habitat?.name.capitalized
    }

    var generation: String {
        species.generation.name.capitalized
    }

    var captureRate: String {
        let rate = (Float(species.captureRate) / 255) * 100
        return String(format: "%.1f", rate) + "%"
    }
}
