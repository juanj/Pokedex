//
//  Name.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct Name {
    let text: String
    let language: String
}

extension Name: Decodable {
    enum CodingKeys: String, CodingKey {
        case name, language
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .name)

        let languageContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .language)
        language = try languageContainer.decode(String.self, forKey: .name)
    }
}
