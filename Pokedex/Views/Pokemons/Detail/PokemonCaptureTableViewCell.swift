//
//  PokemonCaptureTableViewCell.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import UIKit

class PokemonCaptureTableViewCell: UITableViewCell {
    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet weak var habitatLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var captureRateLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()

        habitatLabel.text = ""
        generationLabel.text = ""
        captureRateLabel.text = ""
    }

    func load(viewModel: PokemonCaptureCellViewModel) {
        habitatLabel.text = viewModel.habitat
        generationLabel.text = viewModel.generation
        captureRateLabel.text = viewModel.captureRate

        if let theme = viewModel.theme {
            for label in titleLabels {
                label.textColor = theme.primaryColor
            }
            captureRateLabel.textColor = theme.primaryColor
        }
    }
}
