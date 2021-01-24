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
    private var searchList = [NamedRefType<Item>]()

    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let itemsViewController = ItemsViewController(delegate: self)
        navigationController.setViewControllers([itemsViewController], animated: false)
        self.itemsViewController = itemsViewController
        loadItems()
        loadSearchList()
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

    private func loadSearchList() {
        // There is no search endpoint because of performance reasons. https://github.com/PokeAPI/pokeapi/issues/474
        // As a workaround, query the full list and use the name field to search
        let itemsRequest = ApiRequest(resource: ItemListResource(limit: 2000, offset: 0))
        itemsRequest.load { result in
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

extension ItemsCoordinator: ItemsViewControllerDelegate {
    func loadMoreItems(_ itemsViewController: ItemsViewController) {
        guard !isLoadingItems && !isLastPage else { return }
        loadItems(page: page)
        page += 1
    }

    func loadSearch(_ itemsViewController: ItemsViewController, query: String) {
        let subSet = searchList.filter { $0.name.contains(query.lowercased().replacingOccurrences(of: " ", with: "-")) }
        let group = DispatchGroup()
        for index in 0..<subSet.count {
            group.enter()
            subSet[index].fetch {
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.itemsViewController?.setSearchResults(subSet.compactMap(\.ref)
                                                            .map { ItemCellViewModel(item: $0) })
            self.isLoadingItems = false
        }
    }

    func didSelectItem(_ itemsViewController: ItemsViewController, item: Item) {
        itemsViewController.startLoading()
        let group = DispatchGroup()
        for index in 0..<item.attributes.count {
            group.enter()
            item.attributes[index].fetch {
                group.leave()
            }
        }

        group.notify(queue: .main) {
            itemsViewController.endLoading()
            let itemDetailViewController = ItemDetailViewController(viewModel: ItemDetailViewModel(item: item), delegate: self)
            itemDetailViewController.modalPresentationStyle = .fullScreen
            self.navigationController.present(itemDetailViewController, animated: true, completion: nil)
        }
    }
}

extension ItemsCoordinator: ItemDetailViewControllerDelegate {
    func didTapDismiss(_ itemDetailViewController: ItemDetailViewController) {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
