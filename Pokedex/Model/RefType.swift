//
//  RefType.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation

class RefType<RefType: Decodable>: ApiResource, Decodable {
    typealias ModelType = RefType

    var ref: RefType?
    let resourceUrl: String
    var url: URL {
        return URL(string: resourceUrl)!
    }

    enum CodingKeys: String, CodingKey {
        case url
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        resourceUrl = try container.decode(String.self, forKey: .url)
    }

    func fetch(completion: (() -> Void)? = nil) {
        let request = ApiRequest(resource: self)
        request.load { result in
            if let object = try? result.get() {
                self.ref = object
            }
            completion?()
        }
    }
}
