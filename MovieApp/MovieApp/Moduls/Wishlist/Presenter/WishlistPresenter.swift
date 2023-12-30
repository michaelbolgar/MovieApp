//
//  WishlistPresenter.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 29.12.2023.
//

import UIKit
import RealmSwift

protocol WishlistPresenterProtocol {
    init(view: WishlistVCProtocol)
    var wishlist: Results<WishlistCellModel> { get set }
}

final class WishlistPresenter: WishlistPresenterProtocol {
    
    private unowned var view: WishlistVCProtocol
    
    var wishlist: Results<WishlistCellModel>
    init(view: WishlistVCProtocol) {
        self.view = view
        
        let model = WishlistCellModel()
        wishlist = StorageManager.shared.realm.objects(WishlistCellModel.self)
        
//        let model = [Wis]
////        let models = [
////            WishlistCellModel(
////                image: UIImage(named: "Spider") ?? UIImage(),
////                ganre: "Action",
////                name: "Spider-Man No Way Home",
////                type: "Movie",
////                rating: "5.0"),
////            WishlistCellModel(
////                image: UIImage(named: "Spider") ?? UIImage(),
////                ganre: "Action",
////                name: "Spider-Man No Way Home",
////                type: "Movie",
////                rating: "5.0"),
////            WishlistCellModel(
////                image: UIImage(named: "Spider") ?? UIImage(),
////                ganre: "Action",
////                name: "Spider-Man No Way Home",
////                type: "Movie",
////                rating: "5.0")
////
////        ]
//        wishlist.append(contentsOf: models)
    }
}
