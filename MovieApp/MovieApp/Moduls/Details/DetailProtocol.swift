//
//  DetailProtocol.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import Foundation

// MARK: - DetailViewProtocol
protocol DetailViewProtocol: AnyObject {
    func update(with model: DetailViewController.ViewModel)
    func showLoading()
    func hideLoading()
}

// MARK: - DetailPresenterProtocol
protocol DetailPresenterProtocol: AnyObject {
    func activate()
}
