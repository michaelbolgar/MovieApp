//
//  ViewController.swift
//  MovieApp
//
//  Created by Михаил Болгар on 24.12.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var movieInfoForCell: MovieInfoForCell?

    // MARK: - UI Elements
    let label = UILabel.makeLabel(text: "Hello, world!",
                                  font: UIFont.montserratSemiBold(ofSize: 20),
                                  textColor: .customBlack, numberOfLines: nil)

    let cell = UpcomingCell()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBlue

        view.addSubview(label)
        view.addSubview(cell)

        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        cell.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(150)
        }

#warning("пройтись по запросам и дать им нормальные названия")
//        detailsRequst()
//        collectionRequst()
//        popularRequest()
//        search()
//        slugRequest()
//        loadImages()
//        getGenreMovies()
//        getPersonInfo()
        getRandom()
    }

    private func updateCellWithData() {
        guard let movieInfo = movieInfoForCell else {
            return
        }

        cell.configure(with: movieInfo)
    }

    // MARK: Networking manager methods
    private func getRandom() {
        NetworkingManager.shared.getRandom { result in
            switch result {
            case .success(let movie):
                print("Info about movie: \(movie)")
                self.movieInfoForCell = movie
                self.updateCellWithData()
            case .failure(let error):
                print("Error fetching movie details: \(error)")
            }
        }
    }

    private func getPersonInfo() {
        NetworkingManager.shared.getMovieByActor(for: 6317) { result in
            switch result {
            case .success(let info):
                print("Info about \(info.enName ?? "person"): \(info)")
            case .failure(let error):
                print("Error fetching movie details: \(error)")
            }
        }
    }

    private func getGenreMovies() {
        NetworkingManager.shared.getMoviesByCategory(for: Categories.comedy) { result in
            switch result {
            case .success(let movies):
                print("Movies in genre: \(movies)")
            case .failure(let error):
                print("Error fetching movie details: \(error)")
            }
        }
    }

    private func loadImages() {
        NetworkingManager.shared.getImages(for: 665) { result in
            switch result {
            case .success(let urlPool):
                print("Pool of urls: \(urlPool)")
            case .failure(let error):
                print("Error fetching movie details: \(error)")
            }
        }
    }

    private func slugRequest() {
        NetworkingManager.shared.getColletionMovieList(for: "100_greatest_movies_XXI") { result in
            switch result {
            case .success(let movieCollection):
                print("List of movies: \(movieCollection)")
            case .failure(let error):
                print("Error fetching movie details: \(error)")
            }
        }
    }

    private func detailsRequst() {
        let movieID = 666
        NetworkingManager.shared.getMovieDetails(for: movieID) { result in
            switch result {
            case .success(let movieDetails):
                print("Details for movie: \(movieDetails)")
            case .failure(let error):
                print("Error fetching movie details: \(error)")
            }
        }
    }

    private func collectionRequst() {
        NetworkingManager.shared.getCollections { result in
            switch result {
            case .success(let collections):
                print("Current collections: \(collections)")
            case .failure(let error):
                print("Error fetching collections: \(error)")
            }
        }
    }

    private func popularRequest() {
        NetworkingManager.shared.getPopular { result in
            switch result {
            case .success(let popular):
                print("Current collections: \(popular)")
            case .failure(let error):
                print("Error fetching popular movies: \(error)")
            }
        }
    }

    private func search() {
        NetworkingManager.shared.doSearch(for: "harry potter") { result in
            switch result {
            case .success(let search):
                print("Results: \(search)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
