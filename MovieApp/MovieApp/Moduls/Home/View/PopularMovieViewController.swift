//
//  PopularMovieViewController.swift
//  MovieApp
//
//  Created by Мой Macbook on 03.01.2024.
//

import UIKit
import SnapKit

final class PopularMovieViewController: UIViewController {
    
    var presenter: PopularMoviePresenter!

    
    //MARK: - Properties
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(PopularCategoryCell.self, forCellReuseIdentifier: PopularCategoryCell.identifier)
        return table
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(tableView)
        
        presenter = PopularMoviePresenter()
        
        setupLayout()
        setupTableView()
    }
    
    //MARK: - Functions
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
        tableView.sectionFooterHeight = 0
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension PopularMovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: PopularCategoryCell.identifier, for: indexPath) as! PopularCategoryCell
//        presenter.configure(cell: cell, forRow: indexPath.row)
//        return cell
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension PopularMovieViewController: UITableViewDelegate {
    
}
