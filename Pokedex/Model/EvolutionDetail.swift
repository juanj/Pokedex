//
//  EvolutionDetail.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

struct EvolutionDetail {
    let minLevel: Int?
}

extension EvolutionDetail: Decodable {
    enum CodingKeys: String, CodingKey {
        case minLevel = "min_level"
    }
}
