//
//  PokemonSpritesCellViewModel.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation
import UIKit

struct PokemonSpritesCellViewModel {
    let pokemon: Pokemon
}

extension PokemonSpritesCellViewModel {
    func loadNormalImage(into imageView: UIImageView) {
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

    func loadShinyImage(into imageView: UIImageView) {
        if let urlString = pokemon.sprites.frontShiny, let url = URL(string: urlString) {
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

    var theme: Theme? {
        if let type = pokemon.types.min(by: { $0.slot < $1.slot }), let theme = Theme(type: type.name) {
            return theme
        }
        return nil
    }
}
