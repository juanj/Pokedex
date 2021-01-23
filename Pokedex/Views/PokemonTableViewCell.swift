//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonNumberLabel: UILabel!
    @IBOutlet weak var typesStackView: UIStackView!

    override func prepareForReuse() {
        pokemonImageView.image = nil
        pokemonNameLabel.text = ""
        pokemonNumberLabel.text = ""

        for view in typesStackView.arrangedSubviews {
            view.removeFromSuperview()
            typesStackView.removeArrangedSubview(view)
        }
    }

    func load(viewModel: PokemonCellViewModel) {
        pokemonNameLabel.text = viewModel.name
        pokemonNumberLabel.text = viewModel.number
        viewModel.loadImage(into: pokemonImageView)
    }
}
