//
//  StorageManager.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 27.12.2023.
//

import Foundation
import RealmSwift

final class StorageManager {
    
    // MARK: - Static Properties
    static let shared = StorageManager()
    
    // MARK: - Private Properties
    let realm = try! Realm()
    
  
    
    // MARK: - Private init
    private init() {
    }
    
    // MARK: - Public Methods
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
    
    func deleteAllMovies(from wishlist: Results<WishlistCellModel>) {
        do {
            try realm.write {
                realm.delete(wishlist)
            }
        } catch {
            print("Ошибка при удалении объектов из wishlist: \(error.localizedDescription)")
        }
    }
    
    func deleteMovie(_ movie: WishlistCellModel) {
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
