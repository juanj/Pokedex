//
//  MoveCellViewModel.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation
import UIKit

struct MoveCellViewModel {
    let move: Move
}

extension MoveCellViewModel {
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
}
