//
//  DetailPresenter.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import UIKit
import RealmSwift

final class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    private let networkManager = NetworkingManager.shared
    private let movieId: Int
    private var movieDetail = MovieWishlist()
    private let viewModel = DetailViewController.ViewModel.self
    private let fullMovieUrl = "https://www.kinopoisk.vip/film/"
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func activate() {
        view?.showLoading()
        
        let group = DispatchGroup()
        var galleryImages: [String] = []
        var movieDetails: FullMovieInfo?
        
        // Запрос изображений галереи
        group.enter()
        networkManager.getImages(for: movieId) { result in
            defer { group.leave() }
            switch result {
            case .success(let gallery):
                galleryImages = gallery.docs.compactMap { $0.url ?? $0.previewUrl }
            case .failure(let error):
                print(error)
            }
        }
    
        // Запрос деталей фильма
        group.enter()
        networkManager.getMovieDetails(for: movieId) { result in
            defer { group.leave() }
            switch result {
            case .success(let details):
                movieDetails = details
            case .failure(let error):
                print(error)
            }
        }
        
        // После завершения обоих запросов
        group.notify(queue: .main) { [weak self] in
            guard let self = self, let details = movieDetails else { return }
            
            // Обновляем данные для хранения в Realm
            self.updateMovieWishlist(with: details)
            
            // Формируем ViewModel для обновления UI
            let viewModel = self.createViewModel(with: details, galleryImages: galleryImages)
            self.view?.update(with: viewModel)
            self.view?.hideLoading()
        }
    }
    
    private func updateMovieWishlist(with details: FullMovieInfo) {
        let realm = try! Realm()
        
        if let existingMovieDetail = realm.object(ofType: MovieWishlist.self, forPrimaryKey: movieId) {
            // Update the existing record without changing its primary key
            try! realm.write {
                existingMovieDetail.name = details.name ?? ""
                existingMovieDetail.ganre = details.genres?.first?.name ?? ""
                existingMovieDetail.type = details.type ?? ""
                existingMovieDetail.rating = details.rating?.imdb?.formatted() ?? ""
            }
            self.movieDetail = existingMovieDetail
        } else {
            // Create a new record
            let newMovieDetail = MovieWishlist()
            newMovieDetail.id = movieId
            newMovieDetail.name = details.name ?? ""
            newMovieDetail.ganre = details.genres?.first?.name ?? ""
            newMovieDetail.type = details.type ?? ""
            newMovieDetail.rating = details.rating?.imdb?.formatted() ?? ""
            if let imageUrlString = details.poster?.url, let url = URL(string: imageUrlString) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else {
                        print("Error downloading image: \(error?.localizedDescription ?? "unknown error")")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        newMovieDetail.image = data
                        StorageManager.shared.save(newMovieDetail)
                        self.movieDetail = newMovieDetail
                    }
                }
                task.resume()
            } else {
                // Save data without image
                DispatchQueue.main.async {
                    StorageManager.shared.save(newMovieDetail)
                    self.movieDetail = newMovieDetail
                }
            }
        }
    }
    
    private func createViewModel(with details: FullMovieInfo, galleryImages: [String]) -> DetailViewController.ViewModel {
        let header = self.viewModel.HeaderItem(
            imageURL: details.poster?.url ?? details.poster?.previewUrl,
            duration: details.movieLength,
            genre: details.genres?.first?.name,
            rating: details.rating?.imdb,
            year: details.year,
            trailerClosure: { [weak self] in
                guard let trailerUrl = details.videos.trailers.first?.url else { return }
                self?.view?.playVideo(url: trailerUrl)
            },
            movieClosure: {
                self.view?.playVideo(url: "\(self.fullMovieUrl)\(self.movieId)")
            },
            shareClosure: { [weak self] in self?.userDidTapShare() }
        )
        
        let castAndCrew = details.persons?.compactMap { person in
            self.viewModel.CastAndCrewItem(
                imageURL: person.photo,
                name: person.enName,
                profession: person.enProfession
            )
        } ?? []
        
        let galleryItems = galleryImages.map { self.viewModel.GalleryItem(imageURL: $0) }
        let storyLineItem = DetailViewController.ViewModel.StoryLineItem(
            text: details.description ?? "",
            isExpanded: false // Initial state for expansion
        )
        
        return self.viewModel.init(
            title: details.name ?? "",
            header: header,
            storyLine: storyLineItem,
            castAndCrew: castAndCrew,
            gallery: galleryItems,
            likeBarButtonAction: { [weak self] in self?.addToLikes() }
        )
    }
    
    private func addToLikes() {
        StorageManager.shared.save(movieDetail)
    }
    
    func userDidTapShare() {
        self.view?.showShareView()
    }
    
    func shareToInstagram() {
        view?.shareToInstagram(movieName: movieDetail.name, movieId: movieId)
    }
    
    func shareToTwitter() {
        view?.shareToTwitter(movieName: movieDetail.name)
    }
    
    func shareToFacebook() {
        view?.shareToFacebook(movieName: movieDetail.name, movieId: movieId)
    }
    
    func shareToMessenger() {
        view?.shareToMessenger(movieName: movieDetail.name, movieId: movieId)
    }
    func closeShareView() {
        view?.closeShareView()
    }
}


