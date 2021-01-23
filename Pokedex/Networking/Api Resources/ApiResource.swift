//
//  ApiResource.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

protocol ApiResource {
    associatedtype ModelType: Decodable
    var endpoint: String { get }
    var parameters: [String: String] { get }
}

extension ApiResource {
    var url: URL {
        guard var urlComponents = URLComponents(string: "https://pokeapi.co/api/v2/") else {
            fatalError("Invalid base URL")
        }

        urlComponents.path += endpoint

        urlComponents.queryItems = []
        for parameter in parameters {
            urlComponents.queryItems?.append(URLQueryItem(name: parameter.key, value: parameter.value))
        }

        guard let url = urlComponents.url else {
            fatalError("Cannot get url from url components")
        }

        return url
    }

    var parameters: [String: String] { [:] }
}
