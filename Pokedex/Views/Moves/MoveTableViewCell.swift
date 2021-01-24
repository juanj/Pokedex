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

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let duration: Double = animated ? 0.2 : 0
        UIView.animate(withDuration: duration) {
            self.backgroundColor = highlighted ? .lightBlue : .white
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        let duration: Double = animated ? 0.2 : 0
        UIView.animate(withDuration: duration) {
            self.backgroundColor = selected ? .lightBlue : .white
        }
    }

    func load(viewModel: MoveCellViewModel) {
        moveNameLabel.text = viewModel.name
        moveTypeImageView.image = viewModel.typeImage
    }
}
