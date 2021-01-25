//
//  PokemonSpecies.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

struct PokemonSpecies {
    let genderRate: Int
    let captureRate: Int
    let hatchCounter: Int
    let habitat: NamedRefType<PokemonHabitat>?
    let generation: NamedRefType<Generation>
    let eggGroups: [NamedRefType<EggGroup>]
    let texts: [FlavorText]
    let evolutionChain: RefType<EvolutionChain>
    let varieties: [PokemonSpeciesVariety]
}

extension PokemonSpecies: Decodable {
    enum CodingKeys: String, CodingKey {
        case genderRate = "gender_rate"
        case captureRate = "capture_rate"
        case hatchCounter = "hatch_counter"
        case eggGroups = "egg_groups"
        case evolutionChain = "evolution_chain"
        case texts = "flavor_text_entries"
        case habitat, generation, varieties
    }
}
