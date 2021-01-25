//
//  PokemonStatsTableViewCell.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import UIKit

class PokemonStatsTableViewCell: UITableViewCell {
    @IBOutlet var statsLabels: [UILabel]!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var atkLabel: UILabel!
    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var satkLabel: UILabel!
    @IBOutlet weak var sdefLabel: UILabel!
    @IBOutlet weak var spdLabel: UILabel!
    @IBOutlet weak var hpProgressView: GradientProgressView!
    @IBOutlet weak var atkProgressView: GradientProgressView!
    @IBOutlet weak var defProgressView: GradientProgressView!
    @IBOutlet weak var satkProgressView: GradientProgressView!
    @IBOutlet weak var sdefProgressView: GradientProgressView!
    @IBOutlet weak var spdProgressView: GradientProgressView!

    override func prepareForReuse() {
        super.prepareForReuse()

        hpLabel.text = ""
        atkLabel.text = ""
        defLabel.text = ""
        satkLabel.text = ""
        sdefLabel.text = ""
        spdLabel.text = ""
        hpProgressView.value = 0
        atkProgressView.value = 0
        defProgressView.value = 0
        satkProgressView.value = 0
        sdefProgressView.value = 0
        spdProgressView.value = 0
    }

    func load(viewModel: PokemonStatsCellViewModel) {
        hpLabel.text = viewModel.hp
        hpProgressView.value = viewModel.hpValue
        atkLabel.text = viewModel.attack
        atkProgressView.value = viewModel.attackValue
        defLabel.text = viewModel.defense
        defProgressView.value = viewModel.defenseValue
        satkLabel.text = viewModel.specialAttack
        satkProgressView.value = viewModel.specialAttackValue
        sdefLabel.text = viewModel.specialDefense
        sdefProgressView.value = viewModel.specialDefenseValue
        spdLabel.text = viewModel.speed
        spdProgressView.value = viewModel.speedValue

        if let theme = viewModel.theme {
            for label in statsLabels {
                label.textColor = theme.primaryColor
            }
            hpProgressView.theme = theme
            atkProgressView.theme = theme
            defProgressView.theme = theme
            satkProgressView.theme = theme
            sdefProgressView.theme = theme
            spdProgressView.theme = theme
        }
    }
}
