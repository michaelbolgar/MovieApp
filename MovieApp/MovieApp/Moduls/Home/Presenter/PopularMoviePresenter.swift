//
//  PopularMoviePresenter.swift
//  MovieApp
//
//  Created by Мой Macbook on 03.01.2024.
//

import Foundation
import UIKit

protocol PopularMoviePresenter {
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func cellModelForRowAt(indexPath: IndexPath) -> SearchCellModel
}

class PopularMoviePresenterImpl: PopularMoviePresenter {
    weak var view: PopularMovieView?
    private var cellModels = [SearchCellModel]()

    init(view: PopularMovieView) {
        self.view = view
    }

    func viewDidLoad() {
        loadData()
    }

    private func loadData() {
        cellModels = [SearchCellModel(image: UIImage(named: "riverdale"), rating: "4.5", name: "Riverdale", ageLimit: "PG-13", year: "2021", time: "148 minutes", ganre: "Action", type: "Movie")]
        
        self.view?.reloadData()
    }

    func numberOfRowsInSection() -> Int {
        return cellModels.count
    }

    func cellModelForRowAt(indexPath: IndexPath) -> SearchCellModel {
        return cellModels[indexPath.row]
    }
}


