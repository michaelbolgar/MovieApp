//
//  MovieListController.swift
//  MovieApp
//
//  Created by Admin on 10.01.2024.
//

import UIKit

protocol MovieListPresenterProtocol: AnyObject {
    func numberOfCategories() -> Int
    func category(at index: Int) -> catergoriesModel
    func numberOfSelections() -> Int
    func selection(at index: Int) -> MovieListCellModel
    func didSelectCategory(at index: Int)
}

// MARK: - MovieListViewProtocol

protocol MovieListViewProtocol: AnyObject {
    func reloadCategoryCollectionView()
    func reloadSelectionTableView()
    func selectFirstCategory()
}

final class MovieListController: UIViewController {
    
//    weak var view: MovieListViewProtocol?
    
    //MARK: - Properties
    private lazy var categoryCollectionView: UICollectionView = {
       let layot = UICollectionViewFlowLayout()
        layot.scrollDirection = .horizontal
        layot.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layot)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        return collectionView
    }()
    
    private lazy var selectionMovieTable: UITableView = {
        let element = UITableView()
        element.backgroundColor = .clear
        element.showsVerticalScrollIndicator = false
        element.separatorStyle = .none
        element.rowHeight = 236
        element.allowsSelection = false
        element.register(MovieListCell.self, forCellReuseIdentifier: MovieListCell.identifier)
        element.dataSource = self
        element.delegate = self
        return element
    }()
    
    private let categoryData = [
        catergoriesModel(name: "All"),
        catergoriesModel(name: "Action"),
        catergoriesModel(name: "Comedy"),
        catergoriesModel(name: "Drama"),
        catergoriesModel(name: "Horror"),
        catergoriesModel(name: "Thriller"),
        catergoriesModel(name: "Animation"),
    ]
    
    private let selectionData = [
        MovieListCellModel(image: nil, name: "Marvel Movies"),
        MovieListCellModel(image: nil, name: "Marvel Movies"),
        MovieListCellModel(image: nil, name: "Marvel Movies"),
        MovieListCellModel(image: nil, name: "Marvel Movies"),
    ]
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBlack
        setupViews()
        setupConstraints()
        
//        presenter = MovieListPresenter()
//        presenter.view = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectFirstCell()
    }
    
    //MARK: - Private methods
    private func setupViews() {
        [selectionMovieTable, categoryCollectionView].forEach { self.view.addSubview($0) }
    }
    
    private func selectFirstCell(){
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        categoryCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
    }
    
    private func setupConstraints(){
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(39)
        }
        
        selectionMovieTable.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(6)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension MovieListController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        selectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.identifier, for: indexPath) as! CategoriesCell
        cell.configure(with: categoryData[indexPath.item])
        cell.isSelected ? cell.selectCell() : cell.deselectCell()
        return cell
    }
    
}

    //MARK: - UICollectionViewDelegateFlowLayout
extension MovieListController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 31)
    }
}

    //MARK: - UICollectionViewDelegate
extension MovieListController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! CategoriesCell
            cell.selectCell()
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! CategoriesCell
            cell.deselectCell()
        default:
            break
        }
    }
}

    //MARK: - UITableViewDataSource
extension MovieListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.identifier, for: indexPath) as? MovieListCell else { return UITableViewCell() }
        cell.configureCell(with: selectionData[indexPath.row])
        return cell
    }
}

extension MovieListController: UITableViewDelegate {

}

extension MovieListController: MovieListViewProtocol {
    
    func reloadCategoryCollectionView() {
        categoryCollectionView.reloadData()
    }

    func reloadSelectionTableView() {
        selectionMovieTable.reloadData()
    }

    func selectFirstCategory() {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        categoryCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
    }
}
