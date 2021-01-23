//
//  Colors.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation
import UIKit

extension UIColor {
    private static func colorOrFail(_ name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            fatalError("Cannot find color named \(name)")
        }
        return color
    }

    static let textColor = colorOrFail("Text Color")
    static let darkBlue = colorOrFail("Dark Blue")
    static let lightBlut = colorOrFail("Light Blue")
    static let darkGreen = colorOrFail("Dark Green")
    static let lightGreen = colorOrFail("Light Green")
}
