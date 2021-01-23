//
//  GradientView.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation
import UIKit

class GradientView: UIView {
    private var backgroundLayer: CAGradientLayer = {
        let backgroundLayer = CAGradientLayer()

        let colors: [UIColor] = [.darkBlue, .lightBlut, .darkGreen, .lightGreen]
        backgroundLayer.colors = colors.map(\.cgColor)
        backgroundLayer.locations = [0, 0.33, 0.66, 1]
        backgroundLayer.transform = CATransform3DMakeRotation(-.pi / 2 , 0, 0, 1)

        return backgroundLayer
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundLayer.frame = bounds
    }

    private func sharedInit() {
        layer.addSublayer(backgroundLayer)
    }
}
