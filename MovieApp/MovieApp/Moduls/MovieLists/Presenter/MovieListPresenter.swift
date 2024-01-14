//
//  MovieListPresenter.swift
//  MovieApp
//
//  Created by Admin on 10.01.2024.
//

import UIKit

protocol MovieListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfCategories() -> Int
    func category(at index: Int) -> CatergoriesModel
    func numberOfSelections() -> Int
    func selection(at index: Int) -> MovieInfoForCell
    func didSelectCategory(at index: Int)
    var view: MovieListViewProtocol? { get set }
    var selections: [MovieInfoForCell] { get set }
}

final class MovieListPresenterImpl: MovieListPresenterProtocol {
    
    weak var view: MovieListViewProtocol?
    private let model: [MovieListCellModel]
    
    //MARK: - Mock Data
    let categoryData = [
        CatergoriesModel(name: "Action"),
        CatergoriesModel(name: "Comedy"),
        CatergoriesModel(name: "Horror"),
        CatergoriesModel(name: "Drama"),
        CatergoriesModel(name: "Anime"),
        CatergoriesModel(name: "Cartoon"),
    ]
    
    var selections: [MovieInfoForCell]
    
    //MARK: - Init
    init(model: [MovieListCellModel]) {
        self.model = model
        self.selections = []
    }
    
    //MARK: - Methods
    func viewDidLoad() {
        view?.reloadCategoryCollectionView()
    }
    
    func numberOfCategories() -> Int {
        categoryData.count
    }
    
    func category(at index: Int) -> CatergoriesModel {
        CatergoriesModel(name: categoryData[index].name)
    }
    
    func numberOfSelections() -> Int {
        selections.count
    }
    
    func selection(at index: Int) -> MovieInfoForCell {
        selections[index]
    }
    
    func didSelectCategory(at index: Int) {
        view?.reloadSelectionTableView()
    }
}
