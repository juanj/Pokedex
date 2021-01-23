//
//  Item.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct Item {
    let name: String
    let cost: Int
    let texts: [VersionGroupFlavorText]
    let names: [Name]
    let sprite: String?
}

extension Item: Decodable {
    enum CodingKeys: String, CodingKey {
        case name, cost, names, sprites, `default`
        case flavorTextEntries = "flavor_text_entries"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        cost = try container.decode(Int.self, forKey: .cost)
        texts = try container.decode([VersionGroupFlavorText].self, forKey: .flavorTextEntries)
        names = try container.decode([Name].self, forKey: .names)

        let spritesContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .sprites)
        sprite = try? spritesContainer.decode(String.self, forKey: .default)
    }
}
