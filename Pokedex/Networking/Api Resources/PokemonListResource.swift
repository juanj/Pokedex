//
//  PokemonListResource.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct PokemonListResource: ApiResource {
    typealias ModelType = PaginatedResponse<NamedRefType>

    var limit: Int
    var offset: Int
    var endpoint = "pokemon/"

    init(limit: Int = 20, offset: Int = 0) {
        self.limit = limit
        self.offset = offset
    }

    var parameters: [String : String] {
        return ["limit": "\(limit)", "offset": "\(offset)"]
    }
}
