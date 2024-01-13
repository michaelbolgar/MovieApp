//
//  DetailGalleryView.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 05.01.24.
//

import UIKit

// MARK: - DetailGalleryView
class DetailGalleryView: UIView {

    // MARK: - Properties
    private lazy var photo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    // MARK: - Configure
    private func configure() {
        layer.cornerRadius = 20
        backgroundColor = .customDarkGrey // Set background color for the whole view
        addSubview(photo)
        photo.snp.makeConstraints {
            $0.edges.equalToSuperview() // Remove insets
        }
//        photo.layer.cornerRadius = 20
        photo.clipsToBounds = true
    }
}

// MARK: - DetailGalleryView+Configurable
extension DetailGalleryView: Configurable {
    struct Model {
//        let imageURL: URL?
        let imageURL: String?
    }

    func update(model: Model) {

        guard let imageURL = model.imageURL, let url = URL(string: imageURL) else {
            photo.image = nil
            return
        }
        
        ImageDownloader.shared.downloadImage(from: url) { result in
            switch result {
            case .success(let image):
                self.photo.image = image
            case .failure(let error):
                print(error.localizedDescription)
                self.photo.image = UIImage(named: "filmPhoto")
            }
        }
    }
}

// MARK: - Constants
private enum LayoutConstants {
    static let width = 120
    static let leading = 25
    static let inset = 10
}
