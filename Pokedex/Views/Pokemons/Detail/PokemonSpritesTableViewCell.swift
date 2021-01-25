//
//  PokemonSpritesTableViewCell.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import UIKit

class PokemonSpritesTableViewCell: UITableViewCell {
    @IBOutlet weak var roundBackgroundView: UIView!
    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet weak var normalImageView: UIImageView!
    @IBOutlet weak var shinyImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        roundBackgroundView.layer.cornerRadius = 48
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        normalImageView.image = nil
        shinyImageView.image = nil
    }

    func load(viewModel: PokemonSpritesCellViewModel) {
        viewModel.loadNormalImage(into: normalImageView)
        viewModel.loadShinyImage(into: shinyImageView)

        if let theme = viewModel.theme {
            for label in titleLabels {
                label.textColor = theme.primaryColor
            }
        }
    }
}
