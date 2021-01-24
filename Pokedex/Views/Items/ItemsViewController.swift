//
//  ItemsViewController.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import UIKit

protocol ItemsViewControllerDelegate: AnyObject {
    func loadMoreItems(_ itemsViewController: ItemsViewController)
    func loadSearch(_ itemsViewController: ItemsViewController, query: String)
}

class ItemsViewController: UIViewController {
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var tableView: UITableView!

    private var items = [ItemCellViewModel]()
    private weak var delegate: ItemsViewControllerDelegate?
    private var searchResults = [ItemCellViewModel]()
    private var isSearching: Bool {
        if let text = navigationBar.searchTextField.text, !text.isEmpty {
            return true
        } else {
            return false
        }
    }

    init(delegate: ItemsViewControllerDelegate) {
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

    func addItems(_ items: [ItemCellViewModel]) {
        self.items.append(contentsOf: items)

        // If the data is fetch form the cache, there is a small chance that this method is called before the view is loaded
        if tableView != nil {
            tableView.reloadData()
        }
    }

    func setSearchResults(_ searchResults: [ItemCellViewModel]) {
        self.searchResults = searchResults
        tableView.reloadData()
    }

    private func configureNavigationBar() {
        navigationBar.titleLabel.text = "Items"
        navigationBar.searchTextField.addTarget(self, action: #selector(search), for: .editingChanged)
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = 75
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.CellIds.itemCell)
    }

    @objc func search() {
        tableView.reloadData()
        delegate?.loadSearch(self, query: navigationBar.searchTextField.text ?? "")
    }
}

extension ItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchResults.count
        } else {
            return items.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.itemCell) as? ItemTableViewCell else {
            fatalError("Cannot dequeue cell with reusable identifier \(Constants.CellIds.itemCell)")
        }

        if isSearching {
            cell.load(viewModel: searchResults[indexPath.row])
        } else {
            cell.load(viewModel: items[indexPath.row])
        }

        return cell
    }
}

extension ItemsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard !isSearching else { return }
        if indexPaths.contains(where: { $0.row >= items.count - 10 }) {
            delegate?.loadMoreItems(self)
        }
    }
}
