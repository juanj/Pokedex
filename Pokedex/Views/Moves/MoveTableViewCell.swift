//
//  MoveTableViewCell.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import UIKit

class MoveTableViewCell: UITableViewCell {
    @IBOutlet weak var moveNameLabel: UILabel!
    @IBOutlet weak var moveTypeImageView: UIImageView!

    override func prepareForReuse() {
        moveNameLabel.text = ""
        moveTypeImageView.image = nil
    }

    func load(viewModel: MoveCellViewModel) {
        moveNameLabel.text = viewModel.name
        moveTypeImageView.image = viewModel.typeImage
    }
}
