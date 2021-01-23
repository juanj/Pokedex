//
//  VersionGroupFlavorText.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct VersionGroupFlavorText {
    let text: String
    let language: String
    let version: String
}

extension VersionGroupFlavorText: Decodable {
    enum CodingKeys: String, CodingKey {
        case name, text, language
        case versionGroup = "version_group"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)

        let languageContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .language)
        language = try languageContainer.decode(String.self, forKey: .name)

        let versionContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .versionGroup)
        version = try versionContainer.decode(String.self, forKey: .name)
    }
}
