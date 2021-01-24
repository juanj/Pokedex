//
//  Theme.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation
import UIKit

struct Theme {
    let primaryColor: UIColor
    let gradientColors: [UIColor]

    init(type: String) {
        primaryColor = UIColor.colorOrFail("\(type) Primary")
        gradientColors = [UIColor.colorOrFail("\(type) Gradient 1"), UIColor.colorOrFail("\(type) Gradient 2")]
    }
}

extension Theme {
    static let bug = Theme(type: "Bug")
    static let dark = Theme(type: "Dark")
    static let dragon = Theme(type: "Dragon")
    static let electric = Theme(type: "Electric")
    static let fairy = Theme(type: "Fairy")
    static let fight = Theme(type: "Fight")
    static let fire = Theme(type: "Fire")
    static let flying = Theme(type: "Flying")
    static let ghost = Theme(type: "Ghost")
    static let grass = Theme(type: "Grass")
    static let ground = Theme(type: "Ground")
    static let ice = Theme(type: "Ice")
    static let normal = Theme(type: "Normal")
    static let poison = Theme(type: "Poison")
    static let psychic = Theme(type: "Psychic")
    static let rock = Theme(type: "Rock")
    static let steel = Theme(type: "Steel")
    static let water = Theme(type: "Water")
}
