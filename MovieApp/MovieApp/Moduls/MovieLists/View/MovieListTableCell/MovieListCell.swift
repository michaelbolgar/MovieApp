//
//  MovieListCell.swift
//  MovieApp
//
//  Created by Admin on 10.01.2024.
//

import UIKit
import SnapKit

protocol MovieListCellProtocol: AnyObject{
    func configureCell(with model: MovieListCellModel)
}

final class MovieListCell: UITableViewCell{
    
    //MARK: - Properties
    static let identifier = String(describing: MovieListCell.self)
    
    private var task: URLSessionDataTask?
    private var imageUrl: URL?
    
    private let movieImage:UIImageView = {
        let element = UIImageView()
        element.backgroundColor = .customDarkGrey
        element.layer.cornerRadius = 16
        element.clipsToBounds = true
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    private let playImage:UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "playGroup")
        return element
    }()
    
    private let nameSelectionLabel = UILabel.makeLabel(text: "", font: UIFont.montserratSemiBold(ofSize: 16), textColor: .white, numberOfLines: 1)
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func configureCell(with model: MovieInfoForCell){
        
        task?.cancel()
//        self.movieImage.image = model.poster?.previewUrl
        self.nameSelectionLabel.text = model.name
        
        guard let urlString = model.poster?.url, let url = URL(string: urlString) else {
            movieImage.image = nil
            return
        }

        // Проверка наличия изображения в кэше
        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            movieImage.image = cachedImage
            return
        }

        // Загрузка изображения
        imageUrl = url
        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, self.imageUrl == url else { return }

            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    ImageCache.shared.save(image: image, forKey: urlString)
                    self.movieImage.image = image
                } else {
                    self.movieImage.image = nil
                }
            }
        }
        task?.resume()
    }
    
    private func setupViews(){
        [movieImage, nameSelectionLabel].forEach { self.addSubview($0) }
        [playImage].forEach { self.movieImage.addSubview($0) }
    }
    
    private func setupConstraints(){
        movieImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(168)
        }
        
        playImage.snp.makeConstraints { make in
            make.center.equalTo(movieImage)
        }
        
        nameSelectionLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(12)
            make.leading.equalTo(movieImage.snp.leading)
        }
    }
}


struct MovieListCellModel {
    let image: UIImage?
    let name: String?
}
