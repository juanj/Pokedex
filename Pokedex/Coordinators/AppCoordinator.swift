//
//  AppCoordinator.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let tabBarController = configureTabController()
        navigationController.setViewControllers([tabBarController], animated: false)
    }

    private func configureTabController() -> UITabBarController {
        let tabBarController = UITabBarController()

        let pokemonsNavigationController = UINavigationController()
        pokemonsNavigationController.tabBarItem = UITabBarItem(title: "Pokemon", image: UIImage(named: "pokemons-icon"), selectedImage: nil)
        let movesNavigationController = UINavigationController()
        movesNavigationController.tabBarItem = UITabBarItem(title: "Moves", image: UIImage(named: "moves-icon"), selectedImage: nil)
        let itemsNavigationController = UINavigationController()
        itemsNavigationController.tabBarItem = UITabBarItem(title: "Items", image: UIImage(named: "items-icon"), selectedImage: nil)

        tabBarController.tabBar.tintColor = .black
        tabBarController.viewControllers = [pokemonsNavigationController, movesNavigationController, itemsNavigationController]

        return tabBarController
    }
}
