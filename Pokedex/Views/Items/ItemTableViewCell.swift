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

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let duration: Double = animated ? 0.2 : 0
        UIView.animate(withDuration: duration) {
            self.backgroundColor = highlighted ? .lightBlue : .white
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        let duration: Double = animated ? 0.2 : 0
        UIView.animate(withDuration: duration) {
            self.backgroundColor = selected ? .lightBlue : .white
        }
    }

    func load(viewModel: ItemCellViewModel) {
        itemNameLabel.text = viewModel.name
        itemPriceLabel.text = viewModel.price
        viewModel.loadImage(into: itemImageView)
    }
}
