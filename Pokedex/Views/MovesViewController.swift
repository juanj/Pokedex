//
//  MovesViewController.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import UIKit

class MovesViewController: UIViewController {
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.titleLabel.text = "Moves"
    }
}
