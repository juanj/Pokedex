//
//  PokemonMoveTableViewCell.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import UIKit

class PokemonMoveTableViewCell: UITableViewCell {
    @IBOutlet weak var moveLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!

    override func prepareForReuse() {
        moveLabel.text = ""
        levelLabel.text = ""
        typeImageView.image = nil
    }

    func load(viewModel: PokemonMoveCellViewModel) {
        moveLabel.text = viewModel.name
        levelLabel.text = viewModel.atLevel
        typeImageView.image = viewModel.typeImage
    }
}
