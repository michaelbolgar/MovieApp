//
//  WishlistVC + UITableView.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 31.12.2023.
//

import UIKit

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
