//
//  User.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 27.12.2023.
//

import Foundation
import RealmSwift

final class User: Object {
    @Persisted var fullName = ""
    @Persisted var email = ""
    @Persisted var image = Data()
}
