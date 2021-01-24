//
//  Fonts.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation
import UIKit

extension UIFont {
    private static func fontOrFail(_ name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            fatalError("Cannot find font named \(name)")
        }
        return font
    }

    static func avenir(size: CGFloat) -> UIFont { fontOrFail("Avenir", size: size) }
    static func avenirMedium(size: CGFloat) -> UIFont { fontOrFail("Avenir Medium", size: size) }
    static func avenirHeavy(size: CGFloat) -> UIFont { fontOrFail("Avenir Heavy", size: size) }
}
