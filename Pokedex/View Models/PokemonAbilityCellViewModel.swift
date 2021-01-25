//
//  PokemonAbilityCellViewModel.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

struct PokemonAbilityCellViewModel {
    let ability: PokemonAbility
    let theme: Theme?
}

extension PokemonAbilityCellViewModel {
    var name: String {
        var text = ability.ability.name
        if let name = ability.ability.ref?.names.first(where: { $0.language == "en" }) {
            text = name.text
        }
        if ability.isHidden {
            text += " (hidden)"
        }
        return text
    }

    var description: String? {
        if let effect = ability.ability.ref?.effectEntries.first(where: { $0.language == "en" }) {
            return effect.effect
        }
        return nil
    }
}
