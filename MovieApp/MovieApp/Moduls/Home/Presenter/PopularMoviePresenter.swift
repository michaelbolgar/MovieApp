//
//  PopularMoviePresenter.swift
//  MovieApp
//
//  Created by Мой Macbook on 03.01.2024.
//

import UIKit

protocol PopularMoviePresenter {
    init(view: PopularMovieViewProtocol)
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func cellModelForRowAt(indexPath: IndexPath) -> SearchCellModel
}

final class PopularMoviePresenterImpl: PopularMoviePresenter {
    
    private unowned var view: PopularMovieViewProtocol
    private var cellModels = [SearchCellModel]()
    
    init(view: PopularMovieViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        loadData()
    }
    
    func numberOfRowsInSection() -> Int {
        return cellModels.count
    }
    
    func cellModelForRowAt(indexPath: IndexPath) -> SearchCellModel {
        return cellModels[indexPath.row]
    }
    
    private func loadData() {
        cellModels = [SearchCellModel(image: UIImage(named: "riverdale"), rating: "4.5", name: "Riverdale", ageLimit: "PG-13", year: "2021", time: "148 minutes", ganre: "Action", type: "Movie")]
        
        self.view.reloadData()
    }
}


