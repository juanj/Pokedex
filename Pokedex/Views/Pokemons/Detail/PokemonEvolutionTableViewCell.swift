//
//  PokemonEvolutionTableViewCell.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import UIKit

class PokemonEvolutionTableViewCell: UITableViewCell {
    @IBOutlet weak var fromImageView: UIImageView!
    @IBOutlet weak var toImageView: UIImageView!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()

        fromImageView.image = nil
        toImageView.image = nil
        fromLabel.text = ""
        toLabel.text = ""
        levelLabel.text = ""
    }

    func load(viewModel: PokemonEvolutionCellViewModel) {
        fromLabel.text = viewModel.fromName
        toLabel.text = viewModel.toName
        levelLabel.text = viewModel.level

        viewModel.loadFromImage(into: fromImageView)
        viewModel.loadToImage(into: toImageView)

        if let theme = viewModel.theme {
            levelLabel.textColor = theme.primaryColor
        }
    }
}
