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
    private var searchList = [NamedRefType<Pokemon>]()
    private var lastSearchRequest: UUID? // Kepp track of the last request to update search results only one time

    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let pokemonsViewController = PokemonsViewController(delegate: self)
        navigationController.setViewControllers([pokemonsViewController], animated: false)

        self.pokemonsViewController = pokemonsViewController
        loadPokemons()
        loadSearchList()
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

    private func loadSearchList() {
        // There is no search endpoint because of performance reasons. https://github.com/PokeAPI/pokeapi/issues/474
        // As a workaround, query the full list and use the name field to search
        let pokemonsRequest = ApiRequest(resource: PokemonListResource(limit: 2000, offset: 0))
        pokemonsRequest.load { result in
            switch result {
            case .success(let data):
                self.searchList = data.results
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

extension PokemonsCoordinator: PokemonsViewControllerDelegate {
    func loadMorePokemons(_ pokemonsViewController: PokemonsViewController) {
        guard !isLoadingPokemons && !isLastPage else { return }
        loadPokemons(page: page)
        page += 1
    }

    func loadSearch(_ pokemonsViewController: PokemonsViewController, query: String) {
        let searchRequest = UUID()
        let subSet = searchList.filter { $0.name.contains(query.lowercased().replacingOccurrences(of: " ", with: "-")) }
        let group = DispatchGroup()
        for index in 0..<subSet.count {
            group.enter()
            subSet[index].fetch {
                group.leave()
            }
        }

        group.notify(queue: .main) {
            guard self.lastSearchRequest == searchRequest else { return }
            self.pokemonsViewController?.setSearchResults(subSet.compactMap(\.ref)
                                                            .map { PokemonCellViewModel(pokemon: $0) })
            self.isLoadingPokemons = false
        }
        lastSearchRequest = searchRequest
    }

    func didSelectPokemon(_ pokemonsViewController: PokemonsViewController, pokemon: Pokemon) {
        pokemonsViewController.startLoading()
        let group = DispatchGroup()

        // Time to go for a deep dive!
        // First fetch the pokemon species
        group.enter()
        pokemon.species.fetch {
            // After that we need the evolution chain
            pokemon.species.ref?.evolutionChain.fetch {
                // This is a helper function to explore all evolutions and fetch each specias + default variety
                func exploreEvolutions(_ chainLink: ChainLink) {
                    group.enter()
                    // Fetch species + default variety for this node
                    chainLink.species.fetch {
                        if let defaultVariaty = chainLink.species.ref?.varieties.first(where: { $0.isDefault }) {
                            defaultVariaty.pokemon.fetch {
                                group.leave()
                            }
                        } else {
                            group.leave()
                        }
                    }

                    // Explore next nodes
                    for index in 0..<chainLink.evolvesTo.count {
                        exploreEvolutions(chainLink.evolvesTo[index])
                    }
                }
                // Kickstart the exploration
                if let link = pokemon.species.ref?.evolutionChain.ref?.chain {
                    exploreEvolutions(link)
                }
                group.leave()
            }
        }

        // Fetch all the moves
        for index in 0..<pokemon.moves.count {
            group.enter()
            pokemon.moves[index].move.fetch {
                group.leave()
            }
        }

        // Fetch all abilities
        for index in 0..<pokemon.abilities.count {
            group.enter()
            pokemon.abilities[index].ability.fetch {
                group.leave()
            }
        }

        // Only THEN we can continue
        group.notify(queue: .main) {
            pokemonsViewController.endLoading()
            let pokemonDetailViewController = PokemonDetailViewController(viewModel: PokemonDetailViewModel(pokemon: pokemon), delegate: self)
            pokemonDetailViewController.modalPresentationStyle = .fullScreen
            self.navigationController.present(pokemonDetailViewController, animated: true, completion: nil)
        }
    }
}

extension PokemonsCoordinator: PokemonDetailViewControllerDelegate {
    func didTapDismiss(_ pokemonDetailViewController: PokemonDetailViewController) {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
