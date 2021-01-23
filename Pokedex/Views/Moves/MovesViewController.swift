//
//  MovesViewController.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import UIKit

protocol MovesViewControllerDelegate: AnyObject {
    func loadMoreMoves(_ movesViewController: MovesViewController)
}

class MovesViewController: UIViewController {
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var tableView: UITableView!

    private var moves = [MoveCellViewModel]()
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

        navigationBar.titleLabel.text = "Moves"
        configureTableView()
    }

    func addMoves(_ moves: [MoveCellViewModel]) {
        self.moves.append(contentsOf: moves)

        // If the data is fetch form the cache, there is a small chance that this method is called before the view is loaded
        if tableView != nil {
            tableView?.reloadData()
        }
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = 75
        tableView.register(UINib(nibName: "MoveTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.CellIds.moveCell)
    }
}

extension MovesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moves.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.moveCell) as? MoveTableViewCell else {
            fatalError("Cannot dequeue cell with reusable identifier \(Constants.CellIds.moveCell)")
        }

        cell.load(viewModel: moves[indexPath.row])

        return cell
    }
}

extension MovesViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: { $0.row >= moves.count - 10 }) {
            delegate?.loadMoreMoves(self)
        }
    }
}
