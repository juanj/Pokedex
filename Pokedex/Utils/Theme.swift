//
//  Theme.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation
import UIKit

struct Theme {
    let name: String
    let primaryColor: UIColor
    let gradientColors: [UIColor]

    init?(type: String) {
        name = type

        if let primaryColor = UIColor(named: "\(type.capitalized) Primary") {
            self.primaryColor = primaryColor
        } else {
            return nil
        }

        if let gradient1 = UIColor(named: "\(type.capitalized) Gradient 1"), let gradient2 = UIColor(named: "\(type.capitalized) Gradient 2") {
            gradientColors = [gradient1, gradient2]
        } else {
            return nil
        }
    }
}

extension Theme {
    static let bug = Theme(type: "bug")
    static let dark = Theme(type: "dark")
    static let dragon = Theme(type: "dragon")
    static let electric = Theme(type: "electric")
    static let fairy = Theme(type: "fairy")
    static let fight = Theme(type: "fight")
    static let fire = Theme(type: "fire")
    static let flying = Theme(type: "flying")
    static let ghost = Theme(type: "ghost")
    static let grass = Theme(type: "grass")
    static let ground = Theme(type: "ground")
    static let ice = Theme(type: "ice")
    static let normal = Theme(type: "normal")
    static let poison = Theme(type: "poison")
    static let psychic = Theme(type: "psychic")
    static let rock = Theme(type: "rock")
    static let steel = Theme(type: "steel")
    static let water = Theme(type: "water")
}
