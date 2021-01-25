//
//  PokemonBreedingCellViewModel.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

struct PokemonBreedingCellViewModel {
    let species: PokemonSpecies
    let theme: Theme?
}

extension PokemonBreedingCellViewModel {
    var egg1: String? {
        if let egg = species.eggGroups.first {
            return egg.name.capitalized
        }
        return nil
    }

    var egg2: String? {
        if species.eggGroups.count > 1, let egg = species.eggGroups.last {
            return egg.name.capitalized
        }
        return nil
    }

    var steps: String {
        "\(255 * (species.hatchCounter + 1)) Steps"
    }

    var cycles: String {
        "\(species.hatchCounter) Cycles"
    }

    var feamleRatio: String {
        let ratio = (Float(species.genderRate) / 8) * 100
        return String(format: "%.1f", ratio) + "%"
    }

    var maleRatio: String {
        let ratio = (1 - (Float(species.genderRate) / 8)) * 100
        return String(format: "%.1f", ratio) + "%"
    }
}
