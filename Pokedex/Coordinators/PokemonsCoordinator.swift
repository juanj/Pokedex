//
//  PokemonsCoordinator.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation
import UIKit

class PokemonsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    private var pokemonsViewController: PokemonsViewController?
    private var isLoadingPokemons = false
    private var page = 1
    private var isLastPage = false

    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let pokemonsViewController = PokemonsViewController(delegate: self)
        navigationController.setViewControllers([pokemonsViewController], animated: false)

        self.pokemonsViewController = pokemonsViewController
        loadPokemons()
    }

    private func loadPokemons(page: Int = 0, pageSize: Int = 50) {
        isLoadingPokemons = true
        let pokemonsRequest = ApiRequest(resource: PokemonListResource(limit: pageSize, offset: page * pageSize))
        pokemonsRequest.load { result in
            switch result {
            case .success(let data):
                if (page + 1) * pageSize >= data.count {
                    self.isLastPage = true
                }
                let group = DispatchGroup()
                for index in 0..<data.results.count {
                    group.enter()
                    data.results[index].fetch {
                        group.leave()
                    }
                }

                group.notify(queue: .main) {
                    self.pokemonsViewController?.addPokemons(data.results.compactMap(\.ref)
                                                                .map { PokemonCellViewModel(pokemon: $0) })
                    self.isLoadingPokemons = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.show(error: error.localizedDescription)
                    self.isLoadingPokemons = false
                }
            }
        }
    }

    private func show(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        navigationController.present(alert, animated: true, completion: nil)
    }
}

extension PokemonsCoordinator: PokemonsViewControllerDelegate {
    func loadMorePokemons(_ pokemonsViewController: PokemonsViewController) {
        guard !isLoadingPokemons && !isLastPage else { return }
        loadPokemons(page: page)
        page += 1
    }
}
