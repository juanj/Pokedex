//
//  ItemDetailViewModel.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation
import UIKit

struct ItemDetailViewModel {
    let item: Item
}

extension ItemDetailViewModel {
    var title: String {
        if let name = item.names.first(where: { $0.language == "en" }) {
            return name.text
        } else {
            return item.name
        }
    }

    var price: String {
        "\(item.cost)"
    }

    var description: String? {
        if let text = item.texts.first(where: { $0.language == "en" }) {
            return text.text.replacingOccurrences(of: "\n", with: " ")
        }
        return nil
    }

    func loadImage(into imageView: UIImageView) {
        if let urlString = item.sprite, let url = URL(string: urlString) {
            let request = ImageRequest(url: url)
            request.load { result in
                if let image = try? result.get() {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            }
        }
    }
}
