//
//  PopularCategoryCell.swift
//  MovieApp
//
//  Created by Admin on 26.12.2023.
//

import UIKit

final class PopularCategoryCell: UICollectionViewCell {
    
    // MARK: - Network Properties
    private var task: URLSessionDataTask?
    private var imageUrl: URL?
    
    //MARK: - Properties
    static let identifier = String(describing: PopularCategoryCell.self)
    
    // MARK: - Private UI Properties
    private let backgorundForRaitingView: UIView = {
        let element = UIView()
        element.layer.cornerRadius = 8
        element.backgroundColor = .gray
        element.alpha = 0.9
        return element
    }()
    
    private let filmeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let starForRaitingImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "star")
        return element
    }()
    
    private let nameFilmLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.montserratSemiBold(ofSize: 14)
        element.textColor = .white
        element.numberOfLines = 1
        return element
    }()
    
    private let ganreFilmLabel: UILabel = .makeLabel(
        font: UIFont.montserratRegular(ofSize: 10),
        textColor: .customLightGrey,
        numberOfLines: 1
    )
    
    private let ratingFilmLabel: UILabel = .makeLabel(
        font: UIFont.montserratMedium(ofSize: 12),
        textColor: .customOrange,
        numberOfLines: 1
    )
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.color = .white
        return indicator
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellUI()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        filmeImage.image = nil
        activityIndicator.stopAnimating()
        task?.cancel()
    }
    
    // MARK: - Public Methods
    func configure(with model: MovieInfoForCell) {
        
        // Остановить предыдущую загрузку, если она есть
        task?.cancel()
        
        activityIndicator.startAnimating()
        nameFilmLabel.text = model.name
        ganreFilmLabel.text = model.genres?.first?.name
        ratingFilmLabel.text = model.rating.imdb?.formatted()
        
        guard let urlString = model.poster?.url, let url = URL(string: urlString) else {
            filmeImage.image = nil
            return
        }
        
        // Проверка наличия изображения в кэше
        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            filmeImage.image = cachedImage
            activityIndicator.stopAnimating()
            return
        }
        
        // Загрузка изображения
        imageUrl = url
        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, self.imageUrl == url else { return }
            
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    ImageCache.shared.save(image: image, forKey: urlString)
                    self.filmeImage.image = image
                } else {
                    self.filmeImage.image = nil
                }
                self.activityIndicator.stopAnimating()
            }
        }
        task?.resume()
    }
    
    func configure(with model: MovieRecent) {
        
        task?.cancel()
        
        activityIndicator.startAnimating()
        nameFilmLabel.text = model.name
        ganreFilmLabel.text = model.ganre
        ratingFilmLabel.text = model.rating
        
        if let image = UIImage(data: model.image) {
            filmeImage.image = image
        } else {
            filmeImage.image = nil
        }
        
        activityIndicator.stopAnimating()
    }
}

// MARK: - Setup UI
private extension PopularCategoryCell {
    func setupCellUI() {
        contentView.backgroundColor = .customGrey
        contentView.layer.cornerRadius = 12
    }
    
    func setupViews() {
        [
            filmeImage, backgorundForRaitingView,
            nameFilmLabel, ganreFilmLabel, activityIndicator
        ].forEach { contentView.addSubview($0) }
        
        [starForRaitingImage, ratingFilmLabel].forEach { backgorundForRaitingView.addSubview($0) }
    }
    
    func setupConstraints(){
        filmeImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(53)
        }
        
        nameFilmLabel.snp.makeConstraints { make in
            make.top.equalTo(filmeImage.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        ganreFilmLabel.snp.makeConstraints { make in
            make.top.equalTo(nameFilmLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        backgorundForRaitingView.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(24)
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        starForRaitingImage.snp.makeConstraints { make in
            make.leading.equalTo(backgorundForRaitingView).offset(8)
            make.centerY.equalTo(backgorundForRaitingView)
        }
        
        ratingFilmLabel.snp.makeConstraints { make in
            make.leading.equalTo(starForRaitingImage.snp.trailing).offset(4)
            make.trailing.equalTo(backgorundForRaitingView).inset(8)
            make.centerY.equalTo(backgorundForRaitingView)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
