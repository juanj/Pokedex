//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation
import UIKit

struct PokemonDetailViewModel {
    let pokemon: Pokemon

    private func addEvolutions(_ evolutions: inout [PokemonEvolutionCellViewModel], _ link: ChainLink) {
        guard let pokemon = link.species.ref?.varieties.first(where: { $0.isDefault })?.pokemon.ref else { return }
        for evolvesTo in link.evolvesTo {
            if let toPokemon = evolvesTo.species.ref?.varieties.first(where: { $0.isDefault })?.pokemon.ref {
                let evolution = PokemonEvolutionCellViewModel(fromPokemon: pokemon, toPokemon: toPokemon, detailts: evolvesTo.evolutionDetails)
                evolutions.append(evolution)
            }
            addEvolutions(&evolutions, evolvesTo)
        }
    }
}

extension PokemonDetailViewModel {
    var title: String {
        pokemon.name.capitalized
    }

    var theme: Theme? {
        if let type = pokemon.types.min(by: { $0.slot < $1.slot }), let theme = Theme(type: type.name) {
            return theme
        }
        return nil
    }

    var types: [Theme] {
        pokemon.types.sorted { $0.slot < $1.slot }
            .compactMap { Theme(type: $0.name) }
    }

    var description: String? {
        if let text = pokemon.species.ref?.texts.first(where: { $0.language == "en" }) {
            return text.text.replacingOccurrences(of: "\n", with: " ")
        }
        return nil
    }

    var stats: PokemonStatsCellViewModel {
        PokemonStatsCellViewModel(pokemon: pokemon)
    }

    var breeding: PokemonBreedingCellViewModel? {
        guard let species = pokemon.species.ref else { return nil }
        return PokemonBreedingCellViewModel(species: species, theme: theme)
    }

    var sprites: PokemonSpritesCellViewModel {
        PokemonSpritesCellViewModel(pokemon: pokemon)
    }

    var capture: PokemonCaptureCellViewModel? {
        guard let species = pokemon.species.ref else { return nil }
        return PokemonCaptureCellViewModel(species: species, theme: theme)
    }

    var abilities: [PokemonAbilityCellViewModel] {
        pokemon.abilities.map { PokemonAbilityCellViewModel(ability: $0, theme: theme) }
    }

    var evolutions: [PokemonEvolutionCellViewModel] {
        var evolutions = [PokemonEvolutionCellViewModel]()
        if let firstLink = pokemon.species.ref?.evolutionChain.ref?.chain {
            addEvolutions(&evolutions, firstLink)
        }
        return evolutions
    }

    var moves: [PokemonMoveCellViewModel] {
        pokemon.moves.compactMap {
            guard let move = $0.move.ref, let details = $0.versionGroupDetails.first else { return nil }
            return PokemonMoveCellViewModel(move: move, level: details.levelLearnedAt)
        }
        .sorted { $0.level < $1.level }
    }

    func loadImage(into imageView: UIImageView) {
        if let urlString = pokemon.sprites.frontDefault, let url = URL(string: urlString) {
            let request = ImageRequest(url: url)
            request.load { result in
                if let image = try? result.get() {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            }
        }
    }
}
