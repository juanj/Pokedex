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

    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let movesViewController = MovesViewController()
        navigationController.setViewControllers([movesViewController], animated: false)
        self.movesViewController = movesViewController
        loadMoves()
    }

    private func loadMoves() {
        let movesRequest = ApiRequest(resource: MoveListResource())
        movesRequest.load { result in
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
                    self.movesViewController?.setMoves(data.results.compactMap(\.ref)
                                                        .map { MoveCellViewModel(move: $0) })
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
