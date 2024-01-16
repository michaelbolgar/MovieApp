//
//  MovieRecent.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 15.01.2024.
//

import UIKit
import RealmSwift

final class MovieRecent: Object {
    @Persisted var image = Data()
    @Persisted var ganre = ""
    @Persisted var name = ""
    @Persisted var type = ""
    @Persisted var rating = ""
    @Persisted var id = Int()
}

