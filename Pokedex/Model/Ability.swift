//
//  Ability.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

class Ability: Decodable {
    let name: String
    let names: [Name]
    let texts: [AbilityFlavorText]
}
