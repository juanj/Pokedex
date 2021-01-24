//
//  MoveDetailViewController.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import UIKit

protocol MoveDetailViewControllerDelegate: AnyObject {
    func didTapDismiss(_ moveDetailViewController: MoveDetailViewController)
}

class MoveDetailViewController: UIViewController {
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typesStackView: UIStackView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet var statsLabels: [UILabel]!
    @IBOutlet weak var basePowerLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var ppLabel: UILabel!

    private let viewModel: MoveDetailViewModel
    private weak var delegate: MoveDetailViewControllerDelegate?
    init(viewModel: MoveDetailViewModel, delegate: MoveDetailViewControllerDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.layer.cornerRadius = 48
        loadData()
    }

    private func loadData() {
        if let theme = viewModel.theme {
            gradientView.colors = theme.gradientColors
            gradientView.locations = [0, 1]

            let tagView = TypeTagView()
            tagView.theme = theme
            typesStackView.addArrangedSubview(tagView)
            typesStackView.isHidden = false

            for label in statsLabels {
                label.textColor = theme.primaryColor
            }
        }

        titleLabel.text = viewModel.title
        contentLabel.text = viewModel.description
        basePowerLabel.text = viewModel.basePower
        accuracyLabel.text = viewModel.accuracy
        ppLabel.text = viewModel.pp
    }

    @IBAction func dismiss(_ sender: Any) {
        delegate?.didTapDismiss(self)
    }
}
