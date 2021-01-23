//
//  NetworkRequest.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

enum NetworkRequestError: Error {
    case noResponse
    case httpError(code: Int)
    case noData
}

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) throws -> ModelType
    func load(completion: @escaping (Result<ModelType, Error>) -> Void)
}

extension NetworkRequest {
    func load(url: URL, session: URLSession = .shared, completion: @escaping(Result<ModelType, Error>) -> Void) {
        let task = session.dataTask(with: url) {(data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkRequestError.noResponse))
                return
            }

            guard (200..<300).contains(response.statusCode) else {
                completion(.failure(NetworkRequestError.httpError(code: response.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkRequestError.noData))
                return
            }

            do {
                let object = try self.decode(data)
                completion(.success(object))
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
