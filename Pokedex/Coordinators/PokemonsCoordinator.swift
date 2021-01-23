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

    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let pokemonsViewController = PokemonsViewController()
        navigationController.setViewControllers([pokemonsViewController], animated: false)

        self.pokemonsViewController = pokemonsViewController
        loadPokemons()
    }

    private func loadPokemons() {
        let pokemonsRequest = ApiRequest(resource: PokemonListResource())
        pokemonsRequest.load { result in
            switch result {
            case .success(let data):
                let group = DispatchGroup()
                for index in 0..<data.results.count {
                    group.enter()
                    data.results[index].fetch {
                        group.leave()
                    }
                }

                group.notify(queue: .main) {
                    self.pokemonsViewController?.setPokemons(data.results.compactMap(\.ref)
                                                                .map { PokemonCellViewModel(pokemon: $0) })
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.show(error: error.localizedDescription)
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
