//
//  SectionTitleTableViewCell.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import UIKit

class SectionTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = ""
    }

    func load(text: String, theme: Theme) {
        titleLabel.text = text
        titleLabel.textColor = theme.primaryColor
    }
}
