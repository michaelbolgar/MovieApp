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
    let header = DetailViewController.ViewModel.HeaderItem.self
    let castandcrew = [DetailViewController.ViewModel.CastAndCrewItem].self
    let gallery = DetailViewController.ViewModel.GalleryItem.self
    
    func activate() {
        view?.update(
            with: DetailViewController.ViewModel(
                title: model.title,
                storyLine: model.storyLine,
                header: header.init(
                    imageURL: model.posterImage,
                    duration: model.duration,
                    genre: model.genreFilm,
                    rating: model.rating,
                    year: model.year,
                    trailerClosure: {print("trailerClosure")},
                    shareClosure: {print("shareClosure")}),
                castAndCrew: [.init(imageURL: model.personImage, name: model.personName, profession: model.roleMakingFilm), .init(imageURL: model.personImage, name: model.personName, profession: model.roleMakingFilm), .init(imageURL: model.personImage, name: model.personName, profession: model.roleMakingFilm), .init(imageURL: model.personImage, name: model.personName, profession: model.roleMakingFilm)],
                gallery: [.init(imageURL: model.galeryImage), .init(imageURL: model.galeryImage), .init(imageURL: model.galeryImage), .init(imageURL: model.galeryImage)],
                likeBarButtonAction: {print("likeClosure")}))
    }
}
