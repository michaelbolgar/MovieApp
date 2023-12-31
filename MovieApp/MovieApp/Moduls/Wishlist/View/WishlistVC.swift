//
//  WishlistVC.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 29.12.2023.
//

import UIKit

protocol WishlistVCProtocol: AnyObject {
    func showView(with animate: Bool)
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
        presenter.showView(with: false)
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
        let deleteAlert = AlertHelper.createDeleteAlert { [weak self] confirmDelte in
            guard let self = self else { return }
            
            if confirmDelte {
                self.presenter.deleteAllMovies()
                
                let numberOfRows = self.tableView.numberOfRows(inSection: 0)
                let indexPaths = (0..<numberOfRows).map { IndexPath(row: $0, section: 0) }
                
                self.tableView.performBatchUpdates {
                    self.tableView.deleteRows(at: indexPaths, with: .automatic)
                } completion: { _ in
                    self.presenter.showView(with: true)
                }
            }
        }
        present(deleteAlert, animated: true)
    }
}

// MARK: - WishlistVCProtocol
extension WishlistVC: WishlistVCProtocol {
    
    func showAlert() {
        if !presenter.movies.isEmpty {
            showDeleteAlert()
        }
    }
    
    func showView(with animate: Bool) {
        let isMovieListEmpty = presenter.movies.isEmpty
        
        if animate {
            plugView.alpha = 0
            UIView.animate(withDuration: 0.7) {
                self.plugView.alpha = 1
            }
        }
        plugView.isHidden = !isMovieListEmpty
        tableView.isHidden = isMovieListEmpty
    }
    
    func removeMovie(at indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(LayoutConstrain.plugViewTop)
            make.leading.trailing.equalToSuperview()
                .inset(LayoutConstrain.plugViewLeftRight)
            
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
    
    enum LayoutConstrain {
        static let plugViewTop = 140
        static let plugViewLeftRight = 90
    }
}
