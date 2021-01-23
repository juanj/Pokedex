//
//  MoveListResource.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct MoveListResource: ApiResource {
    typealias ModelType = PaginatedResponse<NamedRefType<Move>>

    var limit: Int
    var offset: Int
    var endpoint = "move/"

    init(limit: Int = 20, offset: Int = 0) {
        self.limit = limit
        self.offset = offset
    }

    var parameters: [String : String] {
        return ["limit": "\(limit)", "offset": "\(offset)"]
    }
}
