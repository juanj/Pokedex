//
//  PokemonsViewController.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import UIKit

protocol PokemonsViewControllerDelegate: AnyObject {
    func loadMorePokemons(_ pokemonsViewController: PokemonsViewController)
    func loadSearch(_ pokemonsViewController: PokemonsViewController, query: String)
}

class PokemonsViewController: UIViewController {
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var tableView: UITableView!

    private var pokemons = [PokemonCellViewModel]()
    private var searchResults = [PokemonCellViewModel]()
    private var isSearching: Bool {
        if let text = navigationBar.searchTextField.text, !text.isEmpty {
            return true
        } else {
            return false
        }
    }

    private weak var delegate: PokemonsViewControllerDelegate?
    init(delegate: PokemonsViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureTableView()
    }

    func addPokemons(_ pokemons: [PokemonCellViewModel]) {
        self.pokemons.append(contentsOf: pokemons)

        // If the data is fetch form the cache, there is a small chance that this method is called before the view is loaded
        if tableView != nil {
            tableView.reloadData()
        }
    }

    func setSearchResults(_ searchResults: [PokemonCellViewModel]) {
        self.searchResults = searchResults
        tableView.reloadData()
    }

    private func configureNavigationBar() {
        navigationBar.titleLabel.text = "Pokemon"
        navigationBar.searchTextField.addTarget(self, action: #selector(search), for: .editingChanged)
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = 75
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.CellIds.pokemonCell)
    }

    @objc func search() {
        tableView.reloadData()
        delegate?.loadSearch(self, query: navigationBar.searchTextField.text ?? "")
    }
}

extension PokemonsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchResults.count
        } else {
            return pokemons.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.pokemonCell) as? PokemonTableViewCell else {
            fatalError("Unable to dequeue cell with reusable identifier \(Constants.CellIds.pokemonCell)")
        }

        if isSearching {
            cell.load(viewModel: searchResults[indexPath.row], tag: indexPath.row)
        } else {
            cell.load(viewModel: pokemons[indexPath.row], tag: indexPath.row)
        }

        return cell
    }
}

extension PokemonsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard !isSearching else { return }
        if indexPaths.contains(where: { $0.row >= pokemons.count - 10 }) {
            delegate?.loadMorePokemons(self)
        }
    }
}
