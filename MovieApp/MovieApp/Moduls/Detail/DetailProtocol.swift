//
//  DetailProtocol.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func update(with model: DetailViewController.ViewModel)
    func showLoading()
    func hideLoading()
}

protocol DetailPresenterProtocol: AnyObject {
    func activate()
}
