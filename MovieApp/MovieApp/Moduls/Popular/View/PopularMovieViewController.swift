//
//  PopularMovieViewController.swift
//  MovieApp
//
//  Created by Мой Macbook on 03.01.2024.
//

import UIKit
import SnapKit

protocol PopularMovieViewProtocol: AnyObject {
    func reloadData()
}

final class PopularMovieViewController: UIViewController {
    
    // MARK: - Presenter
    var presenter: PopularMoviePresenterProtocol!
    
    //MARK: - Private UI Properties
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(
            SearchCell.self,
            forCellReuseIdentifier: SearchCell.identifier
        )
        table.rowHeight = 150
        table.sectionFooterHeight = 0
        table.backgroundColor = .customBlack
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        return indicator
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBar()
        setupTableView()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    private func setupNavigationBar() {
        setNavigationBar(title: "Popular Movies")
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

// MARK: - PopularMovieViewProtocol
extension PopularMovieViewController: PopularMovieViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
}
