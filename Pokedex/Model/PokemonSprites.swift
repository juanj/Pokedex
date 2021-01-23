//
//  PokemonSprites.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct PokemonSprites {
    let frontDefault: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    let frontFemale: String?
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
}

extension PokemonSprites: Decodable {
    // Map names to camelCase
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case frontFemale = "front_female"
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
    }
}
