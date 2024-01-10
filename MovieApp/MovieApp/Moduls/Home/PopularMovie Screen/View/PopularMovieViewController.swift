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
    var presenter: PopularMoviePresenter!
    
    //MARK: - Properties
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        return table
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        setupLayout()
        setupTableView()
        
        presenter = PopularMoviePresenterImpl(view: self)
        presenter.viewDidLoad()
        
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

// MARK: - UITableViewDataSource, UITableViewDelegate

extension PopularMovieViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchCell.identifier,
                for: indexPath) as? SearchCell
        else {
            return UITableViewCell()
        }
        
        let cellModel = presenter.cellModelForRowAt(indexPath: indexPath)
        cell.configure(with: cellModel)
        
        return cell
    }
}

// MARK: - PopularMovieViewProtocol
extension PopularMovieViewController: PopularMovieViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}
