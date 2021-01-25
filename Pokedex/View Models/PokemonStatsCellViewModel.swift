//
//  PokemonStatsCellViewModel.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation
import UIKit

struct PokemonStatsCellViewModel {
    let pokemon: Pokemon
}

extension PokemonStatsCellViewModel {
    var hp: String? {
        if let value = pokemon.stats.first(where: { $0.name == "hp" }) {
            return String(format: "%03d", value.baseStat)
        }
        return nil
    }

    var hpValue: CGFloat {
        if let value = pokemon.stats.first(where: { $0.name == "hp" }) {
            return CGFloat(value.baseStat)/255
        }
        return 0
    }

    var attack: String? {
        if let value = pokemon.stats.first(where: { $0.name == "attack" }) {
            return String(format: "%03d", value.baseStat)
        }
        return nil
    }

    var attackValue: CGFloat {
        if let value = pokemon.stats.first(where: { $0.name == "attack" }) {
            return CGFloat(value.baseStat)/255
        }
        return 0
    }

    var defense: String? {
        if let value = pokemon.stats.first(where: { $0.name == "defense" }) {
            return String(format: "%03d", value.baseStat)
        }
        return nil
    }

    var defenseValue: CGFloat {
        if let value = pokemon.stats.first(where: { $0.name == "defense" }) {
            return CGFloat(value.baseStat)/255
        }
        return 0
    }

    var specialAttack: String? {
        if let value = pokemon.stats.first(where: { $0.name == "special-attack" }) {
            return String(format: "%03d", value.baseStat)
        }
        return nil
    }

    var specialAttackValue: CGFloat {
        if let value = pokemon.stats.first(where: { $0.name == "special-attack" }) {
            return CGFloat(value.baseStat)/255
        }
        return 0
    }

    var specialDefense: String? {
        if let value = pokemon.stats.first(where: { $0.name == "special-defense" }) {
            return String(format: "%03d", value.baseStat)
        }
        return nil
    }

    var specialDefenseValue: CGFloat {
        if let value = pokemon.stats.first(where: { $0.name == "special-defense" }) {
            return CGFloat(value.baseStat)/255
        }
        return 0
    }

    var speed: String? {
        if let value = pokemon.stats.first(where: { $0.name == "speed" }) {
            return String(format: "%03d", value.baseStat)
        }
        return nil
    }

    var speedValue: CGFloat {
        if let value = pokemon.stats.first(where: { $0.name == "speed" }) {
            return CGFloat(value.baseStat)/255
        }
        return 0
    }

    var theme: Theme? {
        if let type = pokemon.types.max(by: { $0.slot < $1.slot }), let theme = Theme(type: type.name) {
            return theme
        }
        return nil
    }
}
