//
//  PopularMoviePresenter.swift
//  MovieApp
//
//  Created by Мой Macbook on 03.01.2024.
//

import UIKit

protocol PopularMoviePresenterProtocol {
    init(view: PopularMovieViewProtocol, movies: [PopularMovies.PopularMovie])
    var movies: [PopularMovies.PopularMovie] { get }
}

final class PopularMoviePresenter: PopularMoviePresenterProtocol {
    
    private unowned var view: PopularMovieViewProtocol
    var movies: [PopularMovies.PopularMovie] = []
    
    init(view: PopularMovieViewProtocol, movies: [PopularMovies.PopularMovie]) {
        self.view = view
        self.movies = movies
    }
}


