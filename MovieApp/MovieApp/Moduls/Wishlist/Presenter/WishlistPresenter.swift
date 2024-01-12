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
    init(view: WishlistVCProtocol, storageManager: StorageManagerProtocol, router: HomeRouterProtocol)
    func showView(with animate: Bool)
    func deleteAllMovies()
    func deleteMovie(at indexPath: IndexPath)
    func showAlert()
    func showDetailsMovie(with id: Int)
}

final class WishlistPresenter: WishlistPresenterProtocol {
    
    private unowned var view: WishlistVCProtocol
    private var storageManager: StorageManagerProtocol
    private var router: HomeRouterProtocol
    
    // здесь мы храним фильмы сохраненные в realm
    var movies: Results<MovieWishlist>
    
    init(view: WishlistVCProtocol, storageManager: StorageManagerProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.storageManager = storageManager
        self.router = router
        
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
    
    func showDetailsMovie(with id: Int) {
        router.showDetails(id)
    }
}
