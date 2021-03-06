//
//  MovesViewController.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import UIKit

protocol MovesViewControllerDelegate: AnyObject {
    func loadMoreMoves(_ movesViewController: MovesViewController)
    func loadSearch(_ movesViewController: MovesViewController, query: String)
    func didSelectMove(_ movesViewController: MovesViewController, move: Move)
}

class MovesViewController: UIViewController {
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var tableView: UITableView!

    private var moves = [MoveCellViewModel]()
    private var searchResults = [MoveCellViewModel]()
    private var isSearching: Bool {
        if let text = navigationBar.searchTextField.text, !text.isEmpty {
            return true
        } else {
            return false
        }
    }

    private weak var delegate: MovesViewControllerDelegate?
    init(delegate: MovesViewControllerDelegate) {
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
        configureKeyboard()
    }

    func addMoves(_ moves: [MoveCellViewModel]) {
        self.moves.append(contentsOf: moves)

        // If the data is fetch form the cache, there is a small chance that this method is called before the view is loaded
        if tableView != nil {
            tableView?.reloadData()
        }
    }

    func setSearchResults(_ searchResults: [MoveCellViewModel]) {
        self.searchResults = searchResults
        tableView.reloadData()
    }

    private func configureNavigationBar() {
        navigationBar.titleLabel.text = "Moves"
        navigationBar.searchTextField.addTarget(self, action: #selector(search), for: .editingChanged)
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.delegate = self
        tableView.rowHeight = 75
        tableView.register(UINib(nibName: "MoveTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.CellIds.moveCell)
    }

    private func configureKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableInsets(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableInsets(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func updateTableInsets(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        if notification.name == UIResponder.keyboardWillShowNotification,
           let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.cgRectValue.height, right: 0)
        } else {
            tableView.contentInset = .zero
        }
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @objc func search() {
        tableView.reloadData()
        delegate?.loadSearch(self, query: navigationBar.searchTextField.text ?? "")
    }
}

extension MovesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchResults.count
        } else {
            return moves.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.moveCell) as? MoveTableViewCell else {
            fatalError("Cannot dequeue cell with reusable identifier \(Constants.CellIds.moveCell)")
        }

        if isSearching {
            cell.load(viewModel: searchResults[indexPath.row])
        } else {
            cell.load(viewModel: moves[indexPath.row])
        }

        return cell
    }
}

extension MovesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            delegate?.didSelectMove(self, move: searchResults[indexPath.row].move)
        } else {
            delegate?.didSelectMove(self, move: moves[indexPath.row].move)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MovesViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard !isSearching else { return }
        if indexPaths.contains(where: { $0.row >= moves.count - 10 }) {
            delegate?.loadMoreMoves(self)
        }
    }
}
