//
//  ApiRequest.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

class ApiRequest<Resource: ApiResource> {
    let resource: Resource

    init(resource: Resource) {
        self.resource = resource
    }
}

extension ApiRequest: NetworkRequest {
    func decode(_ data: Data) throws -> Resource.ModelType {
        let jsonDecoder = JSONDecoder()
        let object = try jsonDecoder.decode(Resource.ModelType.self, from: data)
        return object
    }

    func load(completion: @escaping (Result<Resource.ModelType, Error>) -> Void) {
        load(url: resource.url, completion: completion)
    }
}
