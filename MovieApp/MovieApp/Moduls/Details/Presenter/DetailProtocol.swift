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
    func blurBackground()
    func showLoading()
    func hideLoading()
    func showShareView()
}

// MARK: - DetailPresenterProtocol
protocol DetailPresenterProtocol: AnyObject {
    func activate()
    func userDidTapShare()
}
