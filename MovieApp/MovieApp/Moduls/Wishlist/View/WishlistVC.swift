//
//  WishlistVC.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 29.12.2023.
//

import UIKit

protocol WishlistVCProtocol: AnyObject {
    func showView()
    func deleteAllMovies()
    func showAlert()
    func removeMovie(at indexPath: IndexPath)
}

final class WishlistVC: UIViewController {
    
    // MARK: - Presenter
    var presenter: WishlistPresenterProtocol!
    
    // MARK: - Private UI Properties
    private let plugView = PlugView()
    private var tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(
            WishlistCell.self,
            forCellReuseIdentifier: WishlistCell.identifier
        )
        tableView.separatorStyle = .none
        tableView.backgroundColor = .customBlack
        tableView.rowHeight = 130
        return tableView
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WishlistPresenter(view: self, storageManager: StorageManager.shared)
        presenter.showView()
        setViews()
        setupTableView()
        setupNavigationBar()
        setupConstraints()
    }
    
    // MARK: - Private Actions
    @objc private func deleteAllButtonDidTapped() {
        presenter.showAlert()
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func showDeleteAlert() {
        let alert = UIAlertController(
            title: "",
            message: "Are you sure you want to delete all the movies?",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            
            presenter.deleteAllMovies()
            
            let numberOfRows = self.tableView.numberOfRows(inSection: 0)
            let indexPaths = (0..<numberOfRows).map { IndexPath(row: $0, section: 0) }
            
            self.tableView.performBatchUpdates {
                self.tableView.deleteRows(at: indexPaths, with: .fade)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        [okAction, cancelAction].forEach { alert.addAction($0) }
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension WishlistVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WishlistCell.identifier,
                for: indexPath
            ) as? WishlistCell
        else {
            return UITableViewCell()
        }
        cell.backgroundColor = .customBlack
        cell.selectionStyle = .none
        
        let movie = presenter.movies[indexPath.row]
        
        cell.configure(with:movie)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WishlistVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteMovie(at: indexPath)
        }
    }
}

// MARK: - Setup UI
private extension WishlistVC {
    func setViews() {
        view.backgroundColor = .customBlack
        [plugView, tableView].forEach { view.addSubview($0) }
    }
    
    func setupConstraints() {
        plugView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(140)
            make.left.equalToSuperview().offset(90)
            make.right.equalToSuperview().offset(-90)
        
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupNavigationBar() {
        setNavigationBar(title: "Wishlist")
        let deleteAllButton = UIBarButtonItem(
            image: UIImage(systemName: "trash.circle"),
            style: .done,
            target: self,
            action: #selector(deleteAllButtonDidTapped)
        )
        
        navigationItem.rightBarButtonItem = deleteAllButton
        navigationItem.rightBarButtonItem?.tintColor = .customRed
    }
    
//    enum LayoutConstrain: String {
//        case plugViewTop = 140
//        case plugViewLeftRight = 90
//    }
}

// MARK: - WishlistVCProtocol
extension WishlistVC: WishlistVCProtocol {
    
    func showAlert() {
        showDeleteAlert()
    }
    
    func deleteAllMovies() {
        if presenter.movies.count != 0 {
            showDeleteAlert()
        }
    }
    
    func showView() {
        if presenter.movies.count == 0 {
            tableView.isHidden = true
            plugView.isHidden = false
        } else {
            tableView.isHidden = false
            plugView.isHidden = true
        }
    }
    
    func removeMovie(at indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
