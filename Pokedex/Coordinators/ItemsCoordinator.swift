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
    private var isLoadingItems = false
    private var page = 0
    private var isLastPage = false

    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let itemsViewController = ItemsViewController(delegate: self)
        navigationController.setViewControllers([itemsViewController], animated: false)
        self.itemsViewController = itemsViewController
        loadItems()
    }

    private func loadItems(page: Int = 0, pageSize: Int = 50) {
        let movesRequest = ApiRequest(resource: ItemListResource(limit: pageSize, offset: page * pageSize))
        isLoadingItems = true
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
                    self.itemsViewController?.addItems(data.results.compactMap(\.ref)
                                                        .map { ItemCellViewModel(item: $0) })
                    self.isLoadingItems = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.show(error: error.localizedDescription)
                    self.isLoadingItems = false
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

extension ItemsCoordinator: ItemsViewControllerDelegate {
    func loadMoreItems(_ itemsViewController: ItemsViewController) {
        guard !isLoadingItems && !isLastPage else { return }
        loadItems(page: page)
        page += 1
    }
}
