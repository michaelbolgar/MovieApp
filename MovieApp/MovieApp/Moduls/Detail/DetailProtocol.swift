//
//  DetailProtocol.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import Foundation

protocol BookInput: AnyObject {
//    func update(with model: BookViewController.ViewModel)
    func showLoading()
    func hideLoading()
}

protocol BookOutput: AnyObject {
    func activate()
}
