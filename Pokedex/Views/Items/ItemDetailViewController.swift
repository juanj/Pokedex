//
//  ItemDetailViewController.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import UIKit

protocol ItemDetailViewControllerDelegate: AnyObject {
    func didTapDismiss(_ itemDetailViewController: ItemDetailViewController)
}

class ItemDetailViewController: UIViewController {
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var attributesLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    private let viewModel: ItemDetailViewModel
    private weak var delegate: ItemDetailViewControllerDelegate?
    init(viewModel: ItemDetailViewModel, delegate: ItemDetailViewControllerDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureStyle()
        loadData()
    }

    private func configureStyle() {
        gradientView.colors = [.aquamarineBlue, .pastelGreen]
        gradientView.locations = [0, 1]
        contentView.layer.cornerRadius = 48

        // Keep sharp pixels
        imageView.layer.magnificationFilter = .nearest
        imageView.layer.minificationFilter = .nearest
    }

    private func loadData() {
        viewModel.loadImage(into: imageView)
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        attributesLabel.text = viewModel.attributes
        contentLabel.text = viewModel.description
    }

    @IBAction func dismiss(_ sender: Any) {
        delegate?.didTapDismiss(self)
    }
}
