//
//  DetailPresenter.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import UIKit

// MARK: - DetailPresenter+Protocol
final class DetailPresenter: DetailPresenterProtocol {
    
//    var router: DetailRouter?
    weak var view: DetailViewProtocol?
    let model = DetailModel()
//    let header = DetailViewController.ViewModel.HeaderItem.self
//    let castandcrew = [DetailViewController.ViewModel.CastAndCrewItem].self
//    let gallery = DetailViewController.ViewModel.GalleryItem.self
    
    private let networkManager = NetworkingManager.shared
    private let movieId: Int
    private var movieDetail = MovieWishlist()
    
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
                
                movieDetail.ganre = movieDetails.genres?.first?.name ?? ""
                movieDetail.name = movieDetails.name ?? ""
                movieDetail.type = movieDetails.type ?? ""
                movieDetail.rating = movieDetails.rating?.imdb?.formatted() ?? ""
                movieDetail.id = movieId
            
                if let imageUrl = movieDetails.poster?.url, let url = URL(string: imageUrl) {
                    if let imageData = try? Data(contentsOf: url) {
                        movieDetail.image = imageData
                    }
                }
                
                
                
                
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
                            shareClosure: { [weak self] in
                                
                                self?.userDidTapShare()}),
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
    
    func userDidTapShare() {
           // Обрабатывает нажатие кнопки поделиться, показывает ShareView и т.д.
        self.view?.showShareView()
       }
    
    private func addToLikes() {
        StorageManager.shared.save(movieDetail)
//        NotificationCenter.default.post(name: NSNotification.Name("SavedMovie"), object: nil)
        print("likeButton")
    }
}
