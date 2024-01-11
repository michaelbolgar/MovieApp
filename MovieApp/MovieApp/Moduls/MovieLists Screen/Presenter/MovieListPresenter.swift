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
    func category(at index: Int) -> catergoriesModel
    func numberOfSelections() -> Int
    func selection(at index: Int) -> MovieListCellModel
    func didSelectCategory(at index: Int)
    var view: MovieListViewProtocol? { get set }
}

final class MovieListPresenterImpl: MovieListPresenterProtocol {
    
    weak var view: MovieListViewProtocol?
    private let model: MovieListModel
    
    init(model: MovieListModel) {
        self.model = model
    }
    
    func viewDidLoad() {
        view?.reloadCategoryCollectionView()
    }
    
    func numberOfCategories() -> Int {
        model.categories.count
    }
    
    func category(at index: Int) -> catergoriesModel {
        catergoriesModel(name: model.categories[index])
    }
    
    func numberOfSelections() -> Int {
        model.selections.count
    }
    
    func selection(at index: Int) -> MovieListCellModel {
        model.selections[index]
    }
    
    func didSelectCategory(at index: Int) {
        view?.reloadSelectionTableView()
    }
}
