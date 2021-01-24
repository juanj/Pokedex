//
//  Description.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

struct Description {
    let description: String
    let language: String
}

extension Description: Decodable {
    enum CodingKeys: String, CodingKey {
        case description, language, name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        description = try container.decode(String.self, forKey: .description)

        let languageContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .language)
        language = try languageContainer.decode(String.self, forKey: .name)
    }
}
