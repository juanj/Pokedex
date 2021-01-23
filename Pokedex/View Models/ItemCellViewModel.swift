//
//  ItemCellViewModel.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation
import UIKit

struct ItemCellViewModel {
    let item: Item
}

extension ItemCellViewModel {
    var name: String {
        if let name = item.names.first(where: { $0.language == "en" }) {
            return name.text
        } else {
         return item.name
        }
    }

    var price: String {
        "\(item.cost)"
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
