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
    func save(_ movie: MovieWishlist)
    func fetchUser() -> User?
    func isUserExist(withName name: String) -> Bool
    func deleteAllMovies(from wishlist: Results<MovieWishlist>)
    func deleteMovie(_ movie: MovieWishlist)
}

final class StorageManager: StorageManagerProtocol {
    
    // MARK: - Static Properties
    static let shared = StorageManager()
    static let config = Realm.Configuration(
        schemaVersion: 1,
        deleteRealmIfMigrationNeeded: true
    )
    
    // MARK: - Private Properties
    let realm: Realm
    
    // MARK: - Private init
    private init() {
        Realm.Configuration.defaultConfiguration = StorageManager.config
        realm = try! Realm()
    }
    
    // MARK: - User Methods
    func save(_ user: User) {
        write {
            realm.add(user)
        }
    }
    
    func fetchUser() -> User? {
        realm.objects(User.self).last
    }
    
    func isUserExist(withName name: String) -> Bool {
        realm.objects(User.self).filter("fullName = %@", name).count > 0
    }
    
    // MARK: - Movie Methods
    func save(_ movie: MovieWishlist) {
        write {
            realm.add(movie)
        }
    }
    
    func deleteAllMovies(from wishlist: Results<MovieWishlist>) {
        write {
            realm.delete(wishlist)
        }
    }
    
    func deleteMovie(_ movie: MovieWishlist) {
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
