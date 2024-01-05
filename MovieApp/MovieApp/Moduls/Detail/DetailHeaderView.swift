//
//  DetailHeaderView.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 02.01.24.
//

import UIKit

private enum Titles {
    static let calendar = "calendar"
    static let clock = "clock.fill"
    static let action = "film.fill"
    static let rating = "star.fill"
    static let share = "square.and.arrow.up"
    static let play = "play.fill"
}

final class DetailHeaderView: UIView {
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(red: 31/255, green: 29/255, blue: 43/255, alpha: 0.7).cgColor,
                           UIColor(red: 31/255, green: 29/255, blue: 43/255, alpha: 1).cgColor]
        gradient.locations = [0, 1] // Start and end points of the gradient
        return gradient
    }()
    
    private lazy var posterView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var filmInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        return stack
    }()
    
    private let yearLabel = UILabel()
    private let durationLabel = UILabel()
    private let genreLabel = UILabel()
    private let ratingLabel = UILabel()
    private var trailerClosure: (() -> Void)?
        private var shareClosure: (() -> Void)?
    
    private lazy var trailerButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.backgroundColor = .customOrange
        button.setTitle("  Trailer", for: .normal)
        let image = UIImage(systemName: Titles.play)?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 24
        button.backgroundColor = .customDarkBlue
        button.setImage(UIImage(systemName: Titles.share), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func createSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.snp.makeConstraints { make in
            make.width.equalTo(3)
            make.height.equalTo(10)
//            make.leading.equalToSuperview()
        }
        return separator
    }
    
    private func createLabeledIconView(
        title: UILabel,
        iconName: String,
        color: UIColor = .white) -> UIView {
            
            let view = UIView()
            
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: iconName)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.tintColor = color
            view.addSubview(imageView)
            
            let label = UILabel()
            label.text = "custom"
//            label.text = title.text
            label.textColor = color
            view.addSubview(label)
            
            imageView.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            
            label.snp.makeConstraints { make in
                make.leading.equalTo(imageView.snp.trailing).offset(8)
                make.centerY.equalToSuperview()
            }
            return view
        }
    
    private func configure() {
        
        addSubview(backgroundImageView)
        layer.insertSublayer(gradientLayer, above: backgroundImageView.layer)
        
        let separator1 = createSeparator()
        let separator2 = createSeparator()
        
        let yearView = createLabeledIconView(title: yearLabel,
                                             iconName: Titles.calendar)
        let durationView = createLabeledIconView(title: durationLabel,
                                                 iconName: Titles.clock)
        let genreView = createLabeledIconView(title: genreLabel,
                                              iconName: Titles.action)
        let raitingView = createLabeledIconView(title: ratingLabel,
                                                iconName: Titles.rating,
                                                color: UIColor.customOrange)
        
        [posterView, filmInfoStack, buttonStack, raitingView].forEach { addSubview($0) }
        [yearView, durationView, genreView].forEach { filmInfoStack.addArrangedSubview($0) }
        [trailerButton, shareButton].forEach { buttonStack.addArrangedSubview($0) }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            }
        
        trailerButton.snp.makeConstraints {
            $0.width.equalTo(115)
            $0.height.equalTo(48)
        }
        
        shareButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
        }
        
        posterView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(80)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(posterView.snp.width).multipliedBy(0.85) // Maintain aspect ratio based on your design
            }
        
        filmInfoStack.snp.makeConstraints {
            $0.top.equalTo(posterView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.centerX.equalToSuperview()
//            $0.trailing.equalToSuperview().inset(-250)
        }
        
        raitingView.snp.makeConstraints {
            $0.top.equalTo(filmInfoStack.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(raitingView.snp.bottom).offset(40)
            $0.leading.equalTo(filmInfoStack).offset(70)
            $0.trailing.equalTo(filmInfoStack).offset(-70)
        }
    }
    
    @objc func trailerButtonTapped() {
            trailerClosure?()
        }
        
        @objc func shareButtonTapped() {
            shareClosure?()
        }
    
}

extension DetailHeaderView: Configurable {
    struct Model {
//        let imageURL: URL?
        let imageURL: String?
        let duration: String?
        let genre: String?
        let rating: String?
        let year: String?
        let trailerClosure: () -> Void
        let shareClosure: () -> Void
    }
    
    func update(model: Model) {
        durationLabel.text = model.duration
        genreLabel.text = model.genre
        ratingLabel.text = model.rating
        
//        trailerButton.addTarget(self, action: #selector(model.trailerClosure), for: .touchUpInside)
        
        guard let imageURL = model.imageURL else {
            posterView.image = nil
            return
        }
        
//        URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
//            guard let self = self else { return }
//            
//            if let error = error {
//                // Обработка ошибки загрузки
//                print("Ошибка загрузки изображения: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                print("Некорректный ответ сервера")
//                return
//            }
//            
//            guard let data = data, let image = UIImage(data: data) else {
//                print("Данные не могут быть преобразованы в изображение")
//                return
//            }
//            
//            DispatchQueue.main.async {
//                self.posterView.image = image
//            }
//        }.resume()
        posterView.image = UIImage(named: "Bg")
        backgroundImageView.image = UIImage(named: "Bg")
    }
}
