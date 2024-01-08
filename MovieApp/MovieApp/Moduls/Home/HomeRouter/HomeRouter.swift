//
//  HomeRouter.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 08.01.2024.
//

import UIKit

// MARK: - RouterMain
protocol RouterMainHomeProtocol {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: HomeBuilderProtocol? { get set }
}

// MARK: - ProfileRouterProtocol
protocol HomeRouterProtocol: RouterMainHomeProtocol {
    func initialViewController()
    func showFavorites()
}

// MARK: - ProfileRouter
final class HomeRouter: HomeRouterProtocol {
    var navigationController: UINavigationController?
    var moduleBuilder: HomeBuilderProtocol?
    
    init(navigationController: UINavigationController, moduleBuilder: HomeBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let homeVC = moduleBuilder?.createHomeModule(router: self) else { return }
            navigationController.viewControllers = [homeVC]
        }
    }
    
    func showFavorites() {
        if let navigationController = navigationController {
            guard let wishlistVC = moduleBuilder?.createFavoritesModule() else { return }
            navigationController.pushViewController(wishlistVC, animated: true)
        }
    }
}

