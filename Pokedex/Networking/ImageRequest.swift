//
//  ImageRequest.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation
import UIKit

enum ImageRequestError: Error {
    case decodeFailed
}

class ImageRequest: NetworkRequest {
    let url: URL
    init(url: URL) {
        self.url = url
    }

    func decode(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw ImageRequestError.decodeFailed
        }
        return image
    }

    func load(completion: @escaping (Result<UIImage, Error>) -> Void) {
        load(url: url, completion: completion)
    }
}
