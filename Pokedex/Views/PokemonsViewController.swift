//
//  PokemonsViewController.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import UIKit

class PokemonsViewController: UIViewController {
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var tableView: UITableView!

    private var pokemons = [PokemonCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.titleLabel.text = "Pokemon"
        configureTableView()
    }

    func setPokemons(_ pokemons: [PokemonCellViewModel]) {
        self.pokemons = pokemons
        tableView.reloadData()
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.CellIds.pokemonCell)
    }
}

extension PokemonsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.pokemonCell) else {
            fatalError("Unable to dequeue cell with reusable identifier \(Constants.CellIds.pokemonCell)")
        }

        cell.textLabel?.text = pokemons[indexPath.row].name

        return cell
    }
}
