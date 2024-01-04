//
//  DetailProtocol.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import Foundation

protocol DetailInput: AnyObject {
    func update(with model: DetailViewController.ViewModel)
    func showLoading()
    func hideLoading()
}

protocol DetailOutput: AnyObject {
    func activate()
}
