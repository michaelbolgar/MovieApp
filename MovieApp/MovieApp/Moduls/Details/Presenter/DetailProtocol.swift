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
    func playVideo(url: String)
    func shareToInstagram(movieName: String, movieId: Int)
    func shareToTwitter(movieName: String)
    func shareToFacebook(movieName: String, movieId: Int)
    func shareToMessenger(movieName: String, movieId: Int)
    func closeShareView()
}

// MARK: - DetailPresenterProtocol
protocol DetailPresenterProtocol: AnyObject {
    func activate()
    func userDidTapShare()
    func shareToInstagram()
    func shareToTwitter()
    func shareToFacebook()
    func shareToMessenger()
    func closeShareView()
}
