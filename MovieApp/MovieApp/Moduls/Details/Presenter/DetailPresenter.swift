//
//  DetailPresenter.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import UIKit

// MARK: - DetailPresenter+Protocol
final class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    let model = DetailModel()
//    let header = DetailViewController.ViewModel.HeaderItem.self
//    let castandcrew = [DetailViewController.ViewModel.CastAndCrewItem].self
//    let gallery = DetailViewController.ViewModel.GalleryItem.self
    
    private let networkManager = NetworkingManager.shared
    private let movieDetails: MovieDetails
    
    init(_ movieDetails: MovieDetails) {
        self.movieDetails = movieDetails
    }
    
    func activate() {
        view?.showLoading()
        //
        networkManager.getMovieDetails(for: 666) {
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
        
        //        view?.update(
        //            with: DetailViewController.ViewModel(
        //                title: model.title,
        //                storyLine: model.storyLine,
        //                header: header.init(
        //                    imageURL: model.posterImage,
        //                    duration: model.duration,
        //                    genre: model.genreFilm,
        //                    rating: model.rating,
        //                    year: model.year,
        //                    trailerClosure: {print("trailerClosure")},
        //                    shareClosure: {print("shareClosure")}),
        //                castAndCrew: [.init(imageURL: model.personImage, name: model.personName, profession: model.roleMakingFilm), .init(imageURL: model.personImage, name: model.personName, profession: model.roleMakingFilm), .init(imageURL: model.personImage, name: model.personName, profession: model.roleMakingFilm), .init(imageURL: model.personImage, name: model.personName, profession: model.roleMakingFilm)],
        //                gallery: [.init(imageURL: model.galeryImage), .init(imageURL: model.galeryImage), .init(imageURL: model.galeryImage), .init(imageURL: model.galeryImage)],
        //                likeBarButtonAction: {print("likeClosure")}))
        //    }
    }
    private func addToLikes() {
        print("likeButton")
    }
}
