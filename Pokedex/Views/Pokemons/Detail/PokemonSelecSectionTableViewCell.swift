//
//  PokemonSelecSectionTableViewCell.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import UIKit

protocol PokemonSelecSectionTableViewCellDelegate: AnyObject {
    func didSelect(_ pokemonSelecSectionTableViewCell: PokemonSelecSectionTableViewCell, section: SelectedSection)
}

class PokemonSelecSectionTableViewCell: UITableViewCell {   
    @IBOutlet weak var statsButton: UIButton!
    @IBOutlet weak var evolutionsButton: UIButton!
    @IBOutlet weak var movesButton: UIButton!
    
    var theme: Theme?
    weak var delegate: PokemonSelecSectionTableViewCellDelegate?
    var selection: SelectedSection = .stats {
        didSet {
            updateSelected()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        configureStyle()
    }

    private func configureStyle() {
        statsButton.layer.cornerRadius = 20
        evolutionsButton.layer.cornerRadius = 20
        movesButton.layer.cornerRadius = 20
    }

    private func updateSelected() {
        guard let theme = theme else { return }
        statsButton.backgroundColor = selection == .stats ? theme.primaryColor : .clear
        statsButton.setTitleColor(selection == .stats ? .white : theme.primaryColor, for: .normal)
        evolutionsButton.backgroundColor = selection == .evolutions ? theme.primaryColor : .clear
        evolutionsButton.setTitleColor(selection == .evolutions ? .white : theme.primaryColor, for: .normal)
        movesButton.backgroundColor = selection == .moves ? theme.primaryColor : .clear
        movesButton.setTitleColor(selection == .moves ? .white : theme.primaryColor, for: .normal)
    }

    @IBAction func selectStats(_ sender: Any) {
        selection = .stats
        updateSelected()
    }

    @IBAction func selectAvolutions(_ sender: Any) {
        selection = .evolutions
        updateSelected()
    }

    @IBAction func selectMoves(_ sender: Any) {
        selection = .moves
        updateSelected()
    }
}
