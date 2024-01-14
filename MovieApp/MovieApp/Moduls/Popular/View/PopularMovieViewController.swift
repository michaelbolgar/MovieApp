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
    
    private let activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .white
        indicator.isHidden = true
        return indicator
    }()
    
    //MARK: - Properties
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
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        setupNavigationBar()
        setupTableView()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    func setupNavigationBar() {
        setNavigationBar(title: "Popular Movies")
        title = "Popular Movies"
        let navBarAppearance = UINavigationBarAppearance()

        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.montserratSemiBold(ofSize: 16) ?? UIFont.systemFont(ofSize: 16),
        ]

        navBarAppearance.backgroundColor = .customBlack

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    //MARK: - Functions
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
    }
}



// MARK: - PopularMovieViewProtocol
extension PopularMovieViewController: PopularMovieViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
