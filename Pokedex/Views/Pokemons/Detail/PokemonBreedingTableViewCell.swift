//
//  PokemonBreedingTableViewCell.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import UIKit

class PokemonBreedingTableViewCell: UITableViewCell {
    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet weak var egg1Label: UILabel!
    @IBOutlet weak var egg2Label: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var cyclesLabel: UILabel!
    @IBOutlet weak var femaleRatioLabel: UILabel!
    @IBOutlet weak var maleRatioLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()

        egg1Label.text = ""
        egg2Label.text = ""
        stepsLabel.text = ""
        cyclesLabel.text = ""
        femaleRatioLabel.text = ""
        maleRatioLabel.text = ""
    }

    func load(viewModel: PokemonBreedingCellViewModel) {
        egg1Label.text = viewModel.egg1
        egg2Label.text = viewModel.egg2
        stepsLabel.text = viewModel.steps
        cyclesLabel.text = viewModel.cycles
        femaleRatioLabel.text = viewModel.feamleRatio
        maleRatioLabel.text = viewModel.maleRatio
    }
}
