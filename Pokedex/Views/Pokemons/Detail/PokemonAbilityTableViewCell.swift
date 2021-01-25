//
//  PokemonAbilityTableViewCell.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import UIKit

class PokemonAbilityTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = ""
        contentLabel.text = ""
    }

    func load(viewModel: PokemonAbilityCellViewModel) {
        nameLabel.text = viewModel.name
        contentLabel.text = viewModel.description
        if let theme = viewModel.theme {
            nameLabel.textColor = theme.primaryColor
        }
    }
}
