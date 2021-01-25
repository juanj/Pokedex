//
//  PokemonEvolutionCellViewModel.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation
import UIKit

struct PokemonEvolutionCellViewModel {
    let fromPokemon: Pokemon
    let toPokemon: Pokemon
    let detailts: [EvolutionDetail]
}

extension PokemonEvolutionCellViewModel {
    var level: String? {
        if let level = detailts.first?.minLevel {
            return "Lv. \(level)"
        }
        return nil
    }

    var fromName: String {
        fromPokemon.name.capitalized
    }

    var toName: String {
        toPokemon.name.capitalized
    }

    var theme: Theme? {
        if let type = fromPokemon.types.min(by: { $0.slot < $1.slot }), let theme = Theme(type: type.name) {
            return theme
        }
        return nil
    }

    func loadFromImage(into imageView: UIImageView) {
        if let urlString = fromPokemon.sprites.frontDefault, let url = URL(string: urlString) {
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

    func loadToImage(into imageView: UIImageView) {
        if let urlString = toPokemon.sprites.frontDefault, let url = URL(string: urlString) {
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
