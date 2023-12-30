//
//  StorageManager.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 27.12.2023.
//

import Foundation
import RealmSwift

protocol StorageManagerProtocol {
    func save(_ user: User)
    func fetchUser() -> User?
    func isUserExist(withName name: String) -> Bool
}

final class StorageManager: StorageManagerProtocol {
    
    // MARK: - Static Properties
    static let shared = StorageManager()
    
    // MARK: - Private Properties
    private let realm = try! Realm()
    
    // MARK: - Private init
    private init() {}
    
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
