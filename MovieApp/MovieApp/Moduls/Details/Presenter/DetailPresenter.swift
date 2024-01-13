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
                print(movieDetails?.videos.trailers.first?.url as Any)
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
        let movieDetail = MovieWishlist()
        movieDetail.ganre = details.genres?.first?.name ?? ""
        movieDetail.name = details.name ?? ""
        movieDetail.type = details.type ?? ""
        movieDetail.rating = details.rating?.imdb?.formatted() ?? ""
        movieDetail.id = movieId
        
        if let imageUrlString = details.poster?.url, let url = URL(string: imageUrlString) {
            // Асинхронная загрузка изображения
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error downloading image: \(error?.localizedDescription ?? "unknown error")")
                    return
                }
                
                // Переключаемся на основной поток для обновления UI
                DispatchQueue.main.async {
                    movieDetail.image = data
                    StorageManager.shared.save(movieDetail)
                }
            }
            task.resume()
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
                self?.view?.playTrailer(url: trailerUrl)
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
        
        return self.viewModel.init(
            title: details.name ?? "",
            storyLine: details.description ?? "",
            header: header,
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
    
    func shareToInstagram(imageData: Data) {
        view?.shareToInstagram(imageData: movieDetail.image)
    }
    
    func shareToTwitter() {
        view?.shareToTwitter()
    }
    
    func shareToFacebook() {
        view?.shareToFacebook()
    }
    
    func shareToMessenger() {
        view?.shareToMessenger()
    }
    func closeShareView() {
        view?.closeShareView()
    }
}


