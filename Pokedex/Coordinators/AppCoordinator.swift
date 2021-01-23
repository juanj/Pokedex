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
        pokemonsNavigationController.navigationBar.isHidden = true

        let movesNavigationController = UINavigationController()
        movesNavigationController.tabBarItem = UITabBarItem(title: "Moves", image: UIImage(named: "moves-icon"), selectedImage: nil)
        movesNavigationController.navigationBar.isHidden = true

        let itemsNavigationController = UINavigationController()
        itemsNavigationController.tabBarItem = UITabBarItem(title: "Items", image: UIImage(named: "items-icon"), selectedImage: nil)
        itemsNavigationController.navigationBar.isHidden = true

        tabBarController.tabBar.tintColor = .black
        tabBarController.viewControllers = [pokemonsNavigationController, movesNavigationController, itemsNavigationController]

        let pokemonsCoordinator = PokemonsCoordinator(navigationController: pokemonsNavigationController)
        let movesCoordinator = MovesCoordinator(navigationController: movesNavigationController)
        let itemsCoordinator = ItemsCoordinator(navigationController: itemsNavigationController)
        childCoordinators.append(pokemonsCoordinator)
        childCoordinators.append(movesCoordinator)
        childCoordinators.append(itemsCoordinator)
        pokemonsCoordinator.start()
        movesCoordinator.start()
        itemsCoordinator.start()

        return tabBarController
    }
}
