//
//  StatsSections.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

enum StatsSections: Int, CaseIterable {
    case stats = 1
    case weaknesses
    case abilities
    case breeding
    case capture
    case sprites
}

enum SelectedSection {
    case stats
    case evolutions
    case moves
}
