//
//  WishlistVC.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 29.12.2023.
//

import UIKit

protocol WishlistVCProtocol: AnyObject {
    
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
        return tableView
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WishlistPresenter(view: self)
        if presenter.wishlist.count == 0 {
            tableView.isHidden = true
            plugView.isHidden = false
        } else {
            tableView.isHidden = false
            plugView.isHidden = true
        }
        setViews()
        setupTableView()
        setNavigationBar(title: "Wishlist")
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension WishlistVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.wishlist.count
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
        
        let movie = presenter.wishlist[indexPath.row]

        cell.configure(with:movie)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WishlistVC: UITableViewDelegate {
    
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
}

// MARK: - WishlistVCProtocol
extension WishlistVC: WishlistVCProtocol {
    
}
