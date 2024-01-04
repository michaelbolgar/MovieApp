//
//  ViewController.swift
//  MovieApp
//
//  Created by Михаил Болгар on 24.12.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let label = UILabel.makeLabel(text: "Hello, world!", font: UIFont.montserratSemiBold(ofSize: 20), textColor: .customBlack, numberOfLines: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBlue

        view.addSubview(label)

        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        testRequst()
    }

    private func testRequst() {
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
}
