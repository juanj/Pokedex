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
        tableView.rowHeight = 75
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.CellIds.pokemonCell)
    }
}

extension PokemonsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.pokemonCell) as? PokemonTableViewCell else {
            fatalError("Unable to dequeue cell with reusable identifier \(Constants.CellIds.pokemonCell)")
        }

        cell.load(viewModel: pokemons[indexPath.row])

        return cell
    }
}
