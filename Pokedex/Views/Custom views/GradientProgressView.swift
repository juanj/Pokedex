//
//  GradientProgressView.swift
//  Pokedex
//
//  Created by Juan on 24/01/21.
//

import Foundation
import UIKit

class GradientProgressView: UIView {
    var value: CGFloat = 0.5 {
        didSet {
            refreshProgress()
        }
    }

    var theme: Theme? {
        didSet {
            gradientLayer.colors = theme?.gradientColors.map(\.cgColor)
            gradientLayer.locations = [0, 1]
        }
    }

    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        sharedInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        sharedInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundColor = .progressBackground
        layer.cornerRadius = bounds.height / 2
        gradientLayer.cornerRadius = bounds.height / 2
    }

    private func sharedInit() {
        layer.addSublayer(gradientLayer)
    }

    private func refreshProgress() {
        gradientLayer.frame = CGRect(origin: .zero, size: CGSize(width: bounds.width * value, height: bounds.height))
    }
}
