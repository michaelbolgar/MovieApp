//
//  StorageManager.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 27.12.2023.
//

import Foundation
import RealmSwift

protocol StorageManagerProtocol {
    var realm: Realm { get }
    func save(_ user: User)
    func save(_ movie: Movie)
    func fetchUser() -> User?
    func isUserExist(withName name: String) -> Bool
    func deleteAllMovies(from wishlist: Results<Movie>)
    func deleteMovie(_ movie: Movie)
}

final class StorageManager: StorageManagerProtocol {
    
    // MARK: - Static Properties
    static let shared = StorageManager()
    
    // MARK: - Private Properties
    let realm = try! Realm()
    
    // MARK: - Private init
    private init() {}
    
    // MARK: - Public Methods
    
    // сохранение пользователя
    func save(_ user: User) {
        write {
            realm.add(user)
        }
    }
    
    // сохранения фильма в favorites
    func save(_ movie: Movie) {
        write {
            realm.add(movie)
        }
    }
    
    // загрузка последнего пользователя в списке
    func fetchUser() -> User? {
        realm.objects(User.self).last

    }
    
    // проверка, сохранен ли уже такой юзер
    func isUserExist(withName name: String) -> Bool {
        realm.objects(User.self).filter("fullName = %@", name).count > 0
    }
    
    // удаление всех фильмов
    func deleteAllMovies(from wishlist: Results<Movie>) {
        write {
            realm.delete(wishlist)
        }
    }
    
    // удаление конкретного фильма
    func deleteMovie(_ movie: Movie) {
        write {
            realm.delete(movie)
        }
    }
    
    // MARK: - Private Methods
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
