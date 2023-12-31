//
//  WishlistPresenter.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 29.12.2023.
//

import UIKit
import RealmSwift

protocol WishlistPresenterProtocol {
    var movies: Results<Movie> { get }
    init(view: WishlistVCProtocol, storageManager: StorageManagerProtocol)
    func showView()
    func deleteAllMovies()
    func deleteMovie(at indexPath: IndexPath)
    func showAlert()
}

final class WishlistPresenter: WishlistPresenterProtocol {
    
    private unowned var view: WishlistVCProtocol
    private var storageManager: StorageManagerProtocol
    
    // здесь мы храним фильмы сохраненные в realm
    var movies: Results<Movie>
    
    init(view: WishlistVCProtocol, storageManager: StorageManagerProtocol) {
        self.view = view
        self.storageManager = storageManager
        
//        let movie1 = Movie()
//                movie1.name = "Spider-Man No Way Home"
//                movie1.ganre = "Комедия"
//                movie1.type = "Тип 1"
//                movie1.rating = "8.5"
//                movie1.image = UIImage(named: "Spider")?.jpegData(compressionQuality: 1) ?? Data()
//        
//                StorageManager.shared.save(movie1)
//        
//                let movie2 = Movie()
//                movie2.name = "Spider-Man No Way Home"
//                movie2.ganre = "Драма"
//                movie2.type = "Тип 2"
//                movie2.rating = "7.2"
//                movie2.image = UIImage(named: "Spider")?.jpegData(compressionQuality: 1) ?? Data()
//                StorageManager.shared.save(movie2)
//        
//                let movie3 = Movie()
//                movie3.name = "Spider-Man No Way Home"
//                movie3.ganre = "Боевик"
//                movie3.type = "Тип 3"
//                movie3.rating = "8.0"
//                movie3.image = UIImage(named: "Spider")?.jpegData(compressionQuality: 1) ?? Data()
//                StorageManager.shared.save(movie3)
//        
//                let movie4 = Movie()
//                movie4.name = "ФSpider-Man No Way Home"
//                movie4.ganre = "Научная фантастика"
//                movie4.type = "Тип 4"
//                movie4.rating = "9.1"
//                movie4.image = UIImage(named: "Spider")?.jpegData(compressionQuality: 1) ?? Data()
//                StorageManager.shared.save(movie4)
        
        // инициализируем фильмы из realm
        movies = storageManager.realm.objects(Movie.self)
    }
    
    func showView() {
        view.showView()
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

