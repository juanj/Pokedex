//
//  SceneDelegate.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator!
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let rootNavigationController = UINavigationController()
        rootNavigationController.navigationBar.isHidden = true
        appCoordinator = AppCoordinator(navigationController: rootNavigationController)
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()

        appCoordinator.start()
    }
}

