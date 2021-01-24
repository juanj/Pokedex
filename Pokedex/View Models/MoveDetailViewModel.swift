//
//  MoveDetailViewModel.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

struct MoveDetailViewModel {
    let move: Move
}

extension MoveDetailViewModel {
    var theme: Theme? {
        Theme(type: move.type)
    }

    var title: String {
        if let name = move.names.first(where: { $0.language == "en" }) {
            return name.text
        } else {
            return move.name
        }
    }

    var description: String? {
        if let description = move.texts.first(where: { $0.language == "en" }) {
            return description.text.replacingOccurrences(of: "\n", with: " ")
        }
        return nil
    }

    var basePower: String {
        "\(move.power)"
    }

    var accuracy: String {
        "\(move.accuracy)%"
    }

    var pp: String {
        "\(move.pp)"
    }
}
