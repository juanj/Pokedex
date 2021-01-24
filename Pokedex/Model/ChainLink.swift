//
//  ChainLink.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

struct ChainLink {
    let isBaby: Bool
    let species: NamedRefType<PokemonSpecies>
    let evolutionDetails: [EvolutionDetail]
    let evolvesTo: [ChainLink]
}

extension ChainLink: Decodable {
    enum CodingKeys: String, CodingKey {
        case isBaby = "is_baby"
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case species
    }
}
