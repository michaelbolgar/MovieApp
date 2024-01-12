//
//  PopularMoviePresenter.swift
//  MovieApp
//
//  Created by Мой Macbook on 03.01.2024.
//

import UIKit

// MARK: - PopularMoviePresenterProtocol
protocol PopularMoviePresenterProtocol {
    var movies: [MovieInfoForCell] { get set }
    init(
        view: PopularMovieViewProtocol,
        movies: [MovieInfoForCell],
        router: HomeRouterProtocol
    )
    func updateData()
    func showMovieDetails(with id: Int)
}

// MARK: - PopularMoviePresenterProtocol
final class PopularMoviePresenter: PopularMoviePresenterProtocol {
    
    private unowned var view: PopularMovieViewProtocol
    private var router: HomeRouterProtocol
    var movies: [MovieInfoForCell] = []

    init(
        view: PopularMovieViewProtocol,
        movies: [MovieInfoForCell],
        router: HomeRouterProtocol
    ) {
        self.view = view
        self.movies = movies
        self.router = router
        
        if !movies.isEmpty {
            view.reloadData()
        }
    }
    
    func updateData() {
        view.reloadData()
    }
    
    func showMovieDetails(with id: Int) {
        router.showDetails(id)
    }
}
