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

    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let movesViewController = MovesViewController(delegate: self)
        navigationController.setViewControllers([movesViewController], animated: false)
        self.movesViewController = movesViewController
        loadMoves()
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
}
