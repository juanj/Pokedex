//
//  VerboseEffect.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

struct VerboseEffect {
    let effect: String
    let language: String
}


extension VerboseEffect: Decodable {
    enum CodingKeys: String, CodingKey {
        case language, name, effect
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        effect = try container.decode(String.self, forKey: .effect)

        let languageContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .language)
        language = try languageContainer.decode(String.self, forKey: .name)
    }
}
