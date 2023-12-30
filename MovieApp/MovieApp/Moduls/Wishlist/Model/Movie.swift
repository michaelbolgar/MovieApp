//
//  Movie.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 29.12.2023.
//

import UIKit
import RealmSwift

final class WishlistCellModel: Object {
    @Persisted var image = Data()
    @Persisted var ganre = ""
    @Persisted var name = ""
    @Persisted var type = ""
    @Persisted var rating = ""
}


