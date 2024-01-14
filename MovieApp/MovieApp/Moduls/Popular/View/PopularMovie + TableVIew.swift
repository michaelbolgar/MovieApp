//
//  PopularMovie + TableVIew.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 12.01.2024.
//

import UIKit

// MARK: - UITableViewDataSource
extension PopularMovieViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSrouce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchCell.identifier,
                for: indexPath) as? SearchCell
        else {
            return UITableViewCell()
        }
        
        let cellModel = presenter.movies[indexPath.row]
        cell.configure(with: cellModel)
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PopularMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = presenter.movies[indexPath.row]
        presenter.showMovieDetails(with: movie.id ?? 0)
    }
}
