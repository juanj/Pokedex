//
//  MovesCoordinator.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation
import UIKit

class MovesCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.setViewControllers([MovesViewController()], animated: false)
    }
}
