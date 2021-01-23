//
//  ItemTableViewCell.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!

    override func prepareForReuse() {
        itemImageView.image = nil
        itemNameLabel.text = ""
        itemPriceLabel.text = ""
    }

    func load(viewModel: ItemCellViewModel) {
        itemNameLabel.text = viewModel.name
        itemPriceLabel.text = viewModel.price
        viewModel.loadImage(into: itemImageView)
    }
}
