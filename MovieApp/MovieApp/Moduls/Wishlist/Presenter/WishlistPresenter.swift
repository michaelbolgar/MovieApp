//
//  WishlistPresenter.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 29.12.2023.
//

import UIKit
import RealmSwift

protocol WishlistPresenterProtocol {
    var movies: Results<MovieWishlist> { get }
    init(view: WishlistVCProtocol, storageManager: StorageManagerProtocol)
    func showView(with animate: Bool)
    func deleteAllMovies()
    func deleteMovie(at indexPath: IndexPath)
    func showAlert()
}

final class WishlistPresenter: WishlistPresenterProtocol {
    
    private unowned var view: WishlistVCProtocol
    private var storageManager: StorageManagerProtocol
    
    // здесь мы храним фильмы сохраненные в realm
    var movies: Results<MovieWishlist>
    
    init(view: WishlistVCProtocol, storageManager: StorageManagerProtocol) {
        self.view = view
        self.storageManager = storageManager
        
        // инициализируем фильмы из realm
        movies = storageManager.realm.objects(MovieWishlist.self)
    }
    
    func showView(with animate: Bool) {
        view.showView(with: animate)
    }
    
    // удаление всех фильмов
    func deleteAllMovies() {
        storageManager.deleteAllMovies(from: movies)
    }
    
    // удаление конкретного фильма
    func deleteMovie(at indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        storageManager.deleteMovie(movie)
        view.removeMovie(at: indexPath)
    }
    
    func showAlert() {
        view.showAlert()
    }
}
