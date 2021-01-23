//
//  ItemListResource.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

struct ItemListResource: ApiResource {
    typealias ModelType = PaginatedResponse<NamedRefType<Item>>

    var limit: Int
    var offset: Int
    var endpoint = "item/"

    init(limit: Int = 20, offset: Int = 0) {
        self.limit = limit
        self.offset = offset
    }

    var parameters: [String : String] {
        return ["limit": "\(limit)", "offset": "\(offset)"]
    }
}
