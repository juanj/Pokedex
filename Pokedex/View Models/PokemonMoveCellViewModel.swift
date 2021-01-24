//
//  PokemonMoveCellViewModel.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation
import UIKit

struct PokemonMoveCellViewModel {
    let move: Move
    let level: Int
}

extension PokemonMoveCellViewModel {
    var name: String {
        if let flavorText = move.names.first(where: { $0.language == "en" }) {
            return flavorText.text
        } else {
            return move.name
        }
    }

    var typeImage: UIImage? {
        UIImage(named: "\(move.type)-type-icon")
    }

    var atLevel: String {
        "Level \(level)"
    }
}
