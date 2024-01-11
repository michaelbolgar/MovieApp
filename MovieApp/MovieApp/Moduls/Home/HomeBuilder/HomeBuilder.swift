//
//  HomeBuilder.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 08.01.2024.
//

import UIKit

// MARK: - ModuleBuilderProtocol
protocol HomeBuilderProtocol {
    func createHomeModule(router: HomeRouterProtocol) -> UIViewController
    func createFavoritesModule() -> UIViewController
    func createDetailsModule(_ movieId: Int) -> UIViewController
    func createPopularModule(with movies: [PopularMovies.PopularMovie]) -> UIViewController
}

// MARK: - ModuleBUilder
final class HomeBuilder: HomeBuilderProtocol {

    func createHomeModule(router: HomeRouterProtocol) -> UIViewController {
        let view = HomeViewController()
        let storageManager = StorageManager.shared
        let networkingManager = NetworkingManager.shared
        let presenter = HomePresenter(
            view: view,
            storageManager: storageManager,
            router: router,
            networkingManager: networkingManager
        )
        view.presenter = presenter
        return view
    }
    
    func createFavoritesModule() -> UIViewController {
        let view = WishlistVC()
        let storageManager = StorageManager.shared
        let presenter = WishlistPresenter(view: view, storageManager: storageManager)
        view.presenter = presenter
        return view
    }
    
    func createDetailsModule(_ movieId: Int) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(movieId: movieId)
        presenter.view = view
        view.presenter = presenter
        return view
    }
    
    func createPopularModule(with movies: [PopularMovies.PopularMovie] = []) -> UIViewController {
        let view = PopularMovieViewController()
        let presenter = PopularMoviePresenter(view: view, movies: movies)
        view.presenter = presenter
        return view
    }
}

