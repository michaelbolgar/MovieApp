//
//  DetailPresenter.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import UIKit

// MARK: - DetailPresenter+Protocol
final class DetailPresenter: DetailPresenterProtocol {
    
    var router: DetailRouter?
    weak var view: DetailViewProtocol?
    let model = DetailModel()
//    let header = DetailViewController.ViewModel.HeaderItem.self
//    let castandcrew = [DetailViewController.ViewModel.CastAndCrewItem].self
//    let gallery = DetailViewController.ViewModel.GalleryItem.self
    
    private let networkManager = NetworkingManager.shared
    private let movieId: Int
    
    init(movieId: Int) {
            self.movieId = movieId
        }
    
    func activate() {
        view?.showLoading()
        //
        networkManager.getMovieDetails(for: movieId) {
            [weak self] result in
            
            guard let self else {
                return
            }
            
            switch result {
            case .success(let movieDetails):
                print("presenter \(movieDetails)")
                view?.update(
                    with: .init(
                        title: movieDetails.name ?? "",
                        storyLine: movieDetails.description ?? "",
                        header: .init(
                            imageURL: movieDetails.poster?.previewUrl,
                            duration: movieDetails.movieLength,
                            genre: movieDetails.genres?.first?.name,
                            rating: movieDetails.rating?.imdb,
                            year: movieDetails.year,
                            trailerClosure: {print("trailerClosure")},
                            shareClosure: {print("shareClosure")}),
                        castAndCrew: [.init(
                            imageURL: model.personImage,
                            name: movieDetails.persons?.first?.enName,
                            profession: movieDetails.persons?.first?.enProfession)],
                        gallery: [.init(imageURL: model.galeryImage)],
                        likeBarButtonAction: {
                            [weak self] in
                            
                            self?.addToLikes()
                        }))
                DispatchQueue.main.async {
                    self.view?.hideLoading()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    private func addToLikes() {
        print("likeButton")
    }
}
