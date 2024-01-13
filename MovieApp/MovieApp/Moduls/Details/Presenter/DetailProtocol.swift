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
    func playTrailer(url: String)
    func shareToInstagram(imageData: Data)
    func shareToTwitter()
    func shareToFacebook()
    func shareToMessenger()
    func closeShareView()
}

// MARK: - DetailPresenterProtocol
protocol DetailPresenterProtocol: AnyObject {
    func activate()
    func userDidTapShare()
    func shareToInstagram(imageData: Data)
    func shareToTwitter()
    func shareToFacebook()
    func shareToMessenger()
    func closeShareView()
}
