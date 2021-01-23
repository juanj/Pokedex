//
//  Coordinator.swift
//  Pokedex
//
//  Created by Juan on 23/01/21.
//

import Foundation

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
