//
//  Move.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct Move {
    let name: String
    let accuracy: Int
    let pp: Int
    let power: Int
    let type: String
    let texts: [FlavorText]
    let names: [Name]
}

extension Move: Decodable {
    enum CodingKeys: String, CodingKey {
        case name, accuracy, pp, power, type, names
        case flavorTextEntries = "flavor_text_entries"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        accuracy = try container.decode(Int.self, forKey: .accuracy)
        pp = try container.decode(Int.self, forKey: .pp)
        power = try container.decode(Int.self, forKey: .power)

        let typeContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .type)
        type = try typeContainer.decode(String.self, forKey: .name)

        texts = try container.decode([FlavorText].self, forKey: .flavorTextEntries)
        names = try container.decode([Name].self, forKey: .names)
    }
}
