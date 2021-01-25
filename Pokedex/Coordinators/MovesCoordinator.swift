//
//  MovesCoordinator.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation
import UIKit

class MovesCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    private var movesViewController: MovesViewController?
    private var isLoadingMoves = false
    private var page = 0
    private var isLastPage = false
    private var searchList = [NamedRefType<Move>]()
    private var lastSearchRequest: UUID? // Kepp track of the last request to update search results only one time

    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let movesViewController = MovesViewController(delegate: self)
        navigationController.setViewControllers([movesViewController], animated: false)
        self.movesViewController = movesViewController
        loadMoves()
        loadSearchList()
    }

    private func loadMoves(page: Int = 0, pageSize: Int = 50) {
        isLoadingMoves = true
        let movesRequest = ApiRequest(resource: MoveListResource(limit: pageSize, offset: page * pageSize))
        movesRequest.load { result in
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
                    self.movesViewController?.addMoves(data.results.compactMap(\.ref)
                                                        .map { MoveCellViewModel(move: $0) })
                    self.isLoadingMoves = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.show(error: error.localizedDescription)
                    self.isLoadingMoves = false
                }
            }
        }
    }

    private func loadSearchList() {
        // There is no search endpoint because of performance reasons. https://github.com/PokeAPI/pokeapi/issues/474
        // As a workaround, query the full list and use the name field to search
        let movesRequest = ApiRequest(resource: MoveListResource(limit: 2000, offset: 0))
        movesRequest.load { result in
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

extension MovesCoordinator: MovesViewControllerDelegate {
    func loadMoreMoves(_ movesViewController: MovesViewController) {
        guard !isLoadingMoves && !isLastPage else { return }
        loadMoves(page: page)
        page += 1
    }

    func loadSearch(_ movesViewController: MovesViewController, query: String) {
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
            self.movesViewController?.setSearchResults(subSet.compactMap(\.ref)
                                                        .map { MoveCellViewModel(move: $0) })
            self.isLoadingMoves = false
        }
        self.lastSearchRequest = searchRequest
    }

    func didSelectMove(_ movesViewController: MovesViewController, move: Move) {
        let moveDetailViewController = MoveDetailViewController(viewModel: MoveDetailViewModel(move: move), delegate: self)
        moveDetailViewController.modalPresentationStyle = .fullScreen
        navigationController.present(moveDetailViewController, animated: true, completion: nil)
    }
}

extension MovesCoordinator: MoveDetailViewControllerDelegate {
    func didTapDismiss(_ moveDetailViewController: MoveDetailViewController) {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
