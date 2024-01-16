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
    func showDetails(_ movieId: Int)
    func showPopularScreen(with movies: [MovieInfoForCell])
    func updatePopularScreen(with movies: [MovieInfoForCell])
}

// MARK: - ProfileRouter
final class MyHomeRouter: HomeRouterProtocol {
    var navigationController: UINavigationController?
    var moduleBuilder: HomeBuilderProtocol?
    
    init(navigationController: UINavigationController, moduleBuilder: HomeBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard
                let homeVC = moduleBuilder?.createHomeModule(router: self)
            else {
                return
            }
            navigationController.viewControllers = [homeVC]
        }
    }
    
    func showFavorites() {
        if let navigationController = navigationController {
            guard let wishlistVC = moduleBuilder?.createFavoritesModule(router: self) else { return }
            navigationController.pushViewController(wishlistVC, animated: true)
        }
    }
//    func showFavorites() {
//        if let navigationController = navigationController {
//            let testVC = TestVC()
//            navigationController.pushViewController(testVC, animated: true)
//        }
//    }
    
    func showDetails(_ movieId: Int) {
        if let navigationController = navigationController {
            guard let detailsVC = moduleBuilder?.createDetailsModule(movieId) else { return }
            navigationController.pushViewController(detailsVC, animated: true)
        }
    }
    
    func showPopularScreen(with movies: [MovieInfoForCell] = []) {
        if let navigationController = navigationController {
            guard let popularVC = moduleBuilder?.createPopularModule(with: movies, and: self) else { return }
            navigationController.pushViewController(popularVC, animated: true)
        }
    }
    
    func updatePopularScreen(with movies: [MovieInfoForCell]) {
        if let navigationController = navigationController,
           let popularVC = navigationController.viewControllers.last as? PopularMovieViewController {
            popularVC.presenter.movies = movies
                popularVC.presenter.updateData()
        }
    }
}

