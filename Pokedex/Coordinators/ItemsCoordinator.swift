//
//  ItemsCoordinator.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation
import UIKit

class ItemsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    private var itemsViewController: ItemsViewController?

    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let itemsViewController = ItemsViewController()
        navigationController.setViewControllers([itemsViewController], animated: false)
        self.itemsViewController = itemsViewController
        loadItems()
    }

    private func loadItems() {
        let movesRequest = ApiRequest(resource: ItemListResource())
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
                    self.itemsViewController?.setItems(data.results.compactMap(\.ref)
                                                        .map { ItemCellViewModel(item: $0) })
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
