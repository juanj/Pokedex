//
//  FlavorText.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct FlavorText {
    let text: String
    let language: String
    let game: String
}

extension FlavorText: Decodable {
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case versionGroup = "version_group"
        case language, name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .flavorText)

        let languageContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .language)
        language = try languageContainer.decode(String.self, forKey: .name)

        let versionContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .versionGroup)
        game = try versionContainer.decode(String.self, forKey: .name)
    }
}
