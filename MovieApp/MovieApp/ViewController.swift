//
//  ViewController.swift
//  MovieApp
//
//  Created by Михаил Болгар on 24.12.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let label = UILabel.makeLabel(text: "Hello, world!", 
                                  font: UIFont.montserratSemiBold(ofSize: 20),
                                  textColor: .customBlack, numberOfLines: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBlue

        view.addSubview(label)

        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        detailsRequst()
//        collectionRequst()
//        popularRequest()
        search()
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
