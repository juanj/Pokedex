//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import UIKit

protocol PokemonDetailViewControllerDelegate: AnyObject {
    func didTapDismiss(_ pokemonDetailViewController: PokemonDetailViewController)
}

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var bigTitleLabel: UILabel!
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

    private var selectedSection: SelectedSection = .stats

    private let viewModel: PokemonDetailViewModel
    private weak var delegate: PokemonDetailViewControllerDelegate?
    init(viewModel: PokemonDetailViewModel, delegate: PokemonDetailViewControllerDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewStyle()
        configureTableView()
        loadData()
    }

    private func configureViewStyle() {
        whiteView.layer.cornerRadius = 48
        pokemonImageView.layer.magnificationFilter = .nearest
        pokemonImageView.layer.minificationFilter = .nearest
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        registerCells()
    }

    private func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "test")
        tableView.register(UINib(nibName: "PokemonInfoTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.CellIds.infoCell)
        tableView.register(UINib(nibName: "PokemonSelecSectionTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.CellIds.sectionCell)
        tableView.register(UINib(nibName: "PokemonMoveTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.CellIds.pokemonMoveCell)
        tableView.register(UINib(nibName: "PokemonEvolutionTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.CellIds.pokemonEvolutionCell)
        tableView.register(UINib(nibName: "PokemonStatsTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.CellIds.pokemonStatsCell)
        tableView.register(UINib(nibName: "SectionTitleTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.CellIds.sectionTitleCell)
    }

    private func loadData() {
        viewModel.loadImage(into: pokemonImageView)
        smallTitleLabel.text = viewModel.title
        bigTitleLabel.text = viewModel.title
        if let theme = viewModel.theme {
            gradientView.colors = theme.gradientColors
            gradientView.locations = [0, 1]
            tagView.theme = theme
        }
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
        delegate?.didTapDismiss(self)
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
    func numberOfSections(in tableView: UITableView) -> Int {
        switch selectedSection {
        case .stats:
            return StatsSections.allCases.count + 1
        case .evolutions, .moves:
            return 2
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            switch selectedSection {
            case .stats:
                if let subSection = StatsSections(rawValue: section) {
                    switch subSection {
                    case .stats:
                        return 1
                    case .breeding, .capture, .sprites:
                        return 2
                    case .abilities:
                        return viewModel.abilities.count + 1
                    }
                }
            case .evolutions:
                return viewModel.evolutions.count
            case .moves:
                return viewModel.moves.count
            }
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // Info section
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.infoCell) as? PokemonInfoTableViewCell else {
                    fatalError("Cannor dequeue cell with reusable identifier \(Constants.CellIds.infoCell)")
                }
                cell.descriptionLabel.text = viewModel.description
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.sectionCell) as? PokemonSelecSectionTableViewCell else {
                    fatalError("Cannor dequeue cell with reusable identifier \(Constants.CellIds.sectionCell)")
                }
                if let theme = viewModel.theme {
                    cell.theme = theme
                }
                cell.selection = selectedSection
                cell.delegate = self
                return cell
            }
        } else {
            switch selectedSection {
            case .stats:
                guard let subSection = StatsSections(rawValue: indexPath.section) else {
                    fatalError("Section \(indexPath) not found")
                }
                switch subSection {
                case .stats:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.pokemonStatsCell) as? PokemonStatsTableViewCell else {
                        fatalError("Cannor dequeue cell with reusable identifier \(Constants.CellIds.pokemonStatsCell)")
                    }
                    cell.load(viewModel: viewModel.stats)
                    return cell
                case .abilities:
                    if indexPath.row == 0 {
                        return sectionTitleCell(tableView, title: "Abilities")
                    } else {
                        return defaultCell(tableView)
                    }
                case .breeding:
                    if indexPath.row == 0 {
                        return sectionTitleCell(tableView, title: "Breeding")
                    } else {
                        return defaultCell(tableView)
                    }
                case .capture:
                    if indexPath.row == 0 {
                        return sectionTitleCell(tableView, title: "Capture")
                    } else {
                        return defaultCell(tableView)
                    }
                case .sprites:
                    if indexPath.row == 0 {
                        return sectionTitleCell(tableView, title: "Sprites")
                    } else {
                        return defaultCell(tableView)
                    }
                }
            case .evolutions:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.pokemonEvolutionCell) as? PokemonEvolutionTableViewCell else {
                    fatalError("Cannor dequeue cell with reusable identifier \(Constants.CellIds.pokemonEvolutionCell)")
                }
                cell.load(viewModel: viewModel.evolutions[indexPath.row])
                return cell
            case .moves:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.pokemonMoveCell) as? PokemonMoveTableViewCell else {
                    fatalError("Cannor dequeue cell with reusable identifier \(Constants.CellIds.pokemonMoveCell)")
                }
                cell.load(viewModel: viewModel.moves[indexPath.row])
                return cell
            }
        }
    }

    func sectionTitleCell(_ tableView: UITableView, title: String) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIds.sectionTitleCell) as? SectionTitleTableViewCell else {
            fatalError("Cannor dequeue cell with reusable identifier \(Constants.CellIds.sectionTitleCell)")
        }

        if let theme = viewModel.theme {
            cell.load(text: title, theme: theme)
        }
        return cell
    }

    func defaultCell(_ tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "test") else {
            fatalError()
        }

        return cell
    }
}

extension PokemonDetailViewController: PokemonSelecSectionTableViewCellDelegate {
    func didSelect(_ pokemonSelecSectionTableViewCell: PokemonSelecSectionTableViewCell, section: SelectedSection) {
        selectedSection = section
        tableView.reloadData()
    }
}
