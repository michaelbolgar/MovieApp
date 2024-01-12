//
//  PopularMoviePresenter.swift
//  MovieApp
//
//  Created by Мой Macbook on 03.01.2024.
//

import UIKit

// MARK: - PopularMoviePresenterProtocol
protocol PopularMoviePresenterProtocol {
    init(view: PopularMovieViewProtocol, movies: [MovieInfoForCell])
    var movies: [MovieInfoForCell] { get set }
    func updateData()
}

// MARK: - PopularMoviePresenterProtocol
final class PopularMoviePresenter: PopularMoviePresenterProtocol {
    
    private unowned var view: PopularMovieViewProtocol
    var movies: [MovieInfoForCell] = []

    init(view: PopularMovieViewProtocol, movies: [MovieInfoForCell]) {
        self.view = view
        self.movies = movies
    }
    
    func updateData() {
        view.reloadData()
    }
}


