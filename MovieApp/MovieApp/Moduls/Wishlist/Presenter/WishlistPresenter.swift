//
//  WishlistPresenter.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 29.12.2023.
//

import UIKit

protocol WishlistPresenterProtocol {
    init(view: WishlistVCProtocol)
    var wishlist: [WishlistCellModel] { get set }
}

final class WishlistPresenter: WishlistPresenterProtocol {
    
    private unowned var view: WishlistVCProtocol
    
    var wishlist: [WishlistCellModel] = []
    
    init(view: WishlistVCProtocol) {
        self.view = view
//        wishlist.append(WishlistCellModel(
//            image: UIImage(named: "Spider") ?? UIImage(),
//            ganre: "Action",
//            name: "Spider-Man No Way Home",
//            type: "Movie",
//            rating: "5.0") 
//        )
    }
}
