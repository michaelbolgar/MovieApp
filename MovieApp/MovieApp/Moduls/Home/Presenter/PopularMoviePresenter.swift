//
//  PopularMoviePresenter.swift
//  MovieApp
//
//  Created by Мой Macbook on 03.01.2024.
//

import Foundation
import UIKit

struct PopularCategoryMovieCellModel {
    let image: UIImage
    let name: String
    let ganre: String
    let rating: String
}


protocol PopularMovieProtocol {
    
    var items: [PopularCategoryMovieCellModel] { get }
    func configure(cell: PopularCategoryCell, forRow row: Int)

}

final class PopularMoviePresenter: PopularMovieProtocol {
   
    var items: [PopularCategoryMovieCellModel] = []
    
    func configure(cell: PopularCategoryCell, forRow row: Int) {
        let item = items[row]
        cell.filmeImage.image = item.image
        cell.nameFilmLabel.text = item.name
        cell.ganreFilmLabel.text = item.ganre
        cell.ratingFilmLabel.text = item.rating
    }
}
