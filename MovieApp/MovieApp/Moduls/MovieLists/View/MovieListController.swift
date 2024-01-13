//
//  MovieListController.swift
//  MovieApp
//
//  Created by Admin on 10.01.2024.
//

import UIKit

// MARK: - MovieListViewProtocol

protocol MovieListViewProtocol: AnyObject {
    func reloadCategoryCollectionView()
    func reloadSelectionTableView()
    func selectFirstCategory()
}

final class MovieListController: UIViewController {
    
    var presenter: MovieListPresenterProtocol!
    
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
        element.rowHeight = 152
        element.allowsSelection = false
        element.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        element.dataSource = self
        element.delegate = self
        return element
    }()
    
    var chosenGanreIndexPath:IndexPath
    
    
    init(with chosenGanreIndexPath: IndexPath) {
        self.chosenGanreIndexPath = chosenGanreIndexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBlack
        setupViews()
        setupConstraints()
        
        let model = MovieListCellModel(image: nil, name: nil)
        presenter = MovieListPresenterImpl(model: [model])
        presenter.view = self
        presenter.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectFirstCategory()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToItemCollectionView()
    }
    
    //MARK: - Private methods
    private func setupViews() {
        [selectionMovieTable, categoryCollectionView].forEach { self.view.addSubview($0) }
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
    
    private func getGenreMovies(with genre: Categories) {
        NetworkingManager.shared.getMoviesByCategory(for: genre) { result in
            switch result {
            case .success(let movies):
                print("Movies fetched successfully: \(movies.docs) \n")
                self.presenter.selections = movies.docs
                DispatchQueue.main.async {
                    self.reloadSelectionTableView()
                }
            case .failure(let error):
                print("Error fetching movie details: \(error)")
            }
        }
    }
    
    private func stringToEnum(string: String) -> Categories {
        switch string {
        case "Action":
            return Categories.action
        case "Comedy":
            return Categories.comedy
        case "Drama":
            return Categories.drama
        case "Horror":
            return Categories.horror
        case "Anime":
            return Categories.anime
        case "Cartoon":
            return Categories.cartoon
        default:
            return Categories.action
        }
    }
    
    private func setupNavigationBar() {
        setNavigationBar(title: "Genres")
        title = "Genres"
        let navBarAppearance = UINavigationBarAppearance()

        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.montserratSemiBold(ofSize: 16) ?? UIFont.systemFont(ofSize: 16),
        ]

        navBarAppearance.backgroundColor = .customBlack

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func scrollToItemCollectionView(){
        categoryCollectionView.scrollToItem(at: chosenGanreIndexPath, at: .centeredHorizontally, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension MovieListController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfCategories()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.identifier, for: indexPath) as! CategoriesCell
        let category = presenter.category(at: indexPath.item)
        cell.configure(with: category)
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
            getGenreMovies(with: stringToEnum(string: presenter.category(at: indexPath.item).name))
            reloadSelectionTableView()
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
        presenter.numberOfSelections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        let selection = presenter.selection(at: indexPath.item)
        cell.configure(with: selection)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MovieListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selection = presenter.selection(at: indexPath.item)
        
    }

}

extension MovieListController: MovieListViewProtocol {
    
    func reloadCategoryCollectionView() {
        categoryCollectionView.reloadData()
    }

    func reloadSelectionTableView() {
        DispatchQueue.main.async {
            self.selectionMovieTable.reloadData()
        }
    }

    func selectFirstCategory() {
        let selectedIndexPath = chosenGanreIndexPath
        categoryCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
        getGenreMovies(with: stringToEnum(string: presenter.category(at: selectedIndexPath.item).name))
    }
}
