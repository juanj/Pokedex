//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var bitTitleLabel: UILabel!
    @IBOutlet weak var tagView: TypeTagView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var whiteViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var smallTitleLabel: UILabel!

    private let minHeight: CGFloat = 64
    private let maxHeight: CGFloat = 340
    private var previousScrollOffset: CGFloat = 0
    private let whiteViewMaxHeight: CGFloat = 210

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewStyle()
        configureTableView()
    }

    private func configureViewStyle() {
        whiteView.layer.cornerRadius = 48
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "test")
    }

    private func progressCollapse(_ newHeight: CGFloat) {
        let spaceRemaining = newHeight - minHeight
        let total = maxHeight - minHeight
        let progress = total - spaceRemaining
        pokemonImageView.alpha = 1 - (progress / (total - 100))
        whiteView.layer.cornerRadius = 48 * (1 - (progress / (total - 100)))
        whiteViewHeightConstraint.constant = whiteViewMaxHeight * (1 - (progress / (total - 50)))
        infoStackView.alpha = 1 - (progress / (total - 100))
        smallTitleLabel.alpha = (progress / (total - 100))
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension PokemonDetailViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Implementing a collapsable header functionality was harder than expected.
        // Fortunately I found an article describing how to do it.
        // Thanks to Ahmed Bahgat
        // https://medium.com/@ahmedbahgatnabih/how-to-make-expandable-and-collapsible-header-for-tableview-in-swift-8ca82075acaa
        let scrollDiff = (scrollView.contentOffset.y - previousScrollOffset)
        let isScrollingDown = scrollDiff > 0
        let isScrollingUp = scrollDiff < 0
        if canAnimateHeader(scrollView) {
            var newHeight = headerHeightConstraint.constant
            if isScrollingDown {
                newHeight = max(minHeight, headerHeightConstraint.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(maxHeight, headerHeightConstraint.constant + abs(scrollDiff))
            }
            if newHeight != headerHeightConstraint.constant {
                headerHeightConstraint.constant = newHeight
                setScrollPosition()
                previousScrollOffset = scrollView.contentOffset.y
                progressCollapse(newHeight)
                view.layoutIfNeeded()
            }
        }
    }

    private func canAnimateHeader (_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + headerHeightConstraint.constant - minHeight
        return scrollView.contentSize.height > scrollViewMaxHeight
    }

    private func setScrollPosition() {
        self.tableView.contentOffset = CGPoint(x:0, y: 0)
    }
}

extension PokemonDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "test") else {
            fatalError()
        }

        return cell
    }
}
