//
//  PokemonCellViewModel.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation
import UIKit

struct PokemonCellViewModel {
    let pokemon: Pokemon
}

extension PokemonCellViewModel {
    var number: String {
        String(format: "#%03d", pokemon.id)
    }

    var name: String {
        pokemon.name.capitalized
    }

    var types: [UIImage] {
        pokemon.types.map(\.name)
            .compactMap { UIImage(named: "\($0)-type-icon") }
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
