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
    
    private lazy var posterView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var filmInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
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
        button.setImage(UIImage(named: Titles.play), for: .normal)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.setImage(UIImage(named: Titles.share), for: .normal)
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
    
    private func createSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.snp.makeConstraints { make in
            make.width.equalTo(1)
        }
        return separator
    }
    
    private func createLabeledIconView(
        title: UILabel,
        iconName: String,
        color: UIColor = .black) -> UIView {
            
            let view = UIView()
            
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: iconName)
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
            
            let label = UILabel()
            label.text = title.text
            view.addSubview(label)
            
            imageView.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            
            label.snp.makeConstraints { make in
                make.leading.equalTo(imageView.snp.trailing).offset(8)
                make.trailing.equalToSuperview()
                make.centerY.equalTo(imageView.snp.centerY)
            }
            
            return view
        }
    
    private func configure() {
        let separator = createSeparator()
        
        let yearView = createLabeledIconView(title: yearLabel,
                                             iconName: Titles.calendar)
        let durationView = createLabeledIconView(title: durationLabel,
                                                 iconName: Titles.clock)
        let genreView = createLabeledIconView(title: genreLabel,
                                              iconName: Titles.action)
        let raitingView = createLabeledIconView(title: ratingLabel,
                                                iconName: Titles.rating,
                                                color: UIColor.customOrange)
        
        [posterView, filmInfoStack, buttonStack].forEach { addSubview($0) }
        [yearView, separator, durationView, separator, genreView].forEach { filmInfoStack.addArrangedSubview($0) }
        [trailerButton, shareButton].forEach { buttonStack.addArrangedSubview($0) }
        
        trailerButton.snp.makeConstraints {
            $0.width.equalTo(30)
        }
        
        posterView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalTo(posterView.snp.width).multipliedBy(1.55).priority(999)
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        filmInfoStack.snp.makeConstraints {
            $0.top.equalTo(posterView.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(posterView).offset(30)
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(filmInfoStack.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(filmInfoStack)
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
        let imageURL: URL?
        let duration: String?
        let genre: String?
        let rating: String?
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
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                // Обработка ошибки загрузки
                print("Ошибка загрузки изображения: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Некорректный ответ сервера")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Данные не могут быть преобразованы в изображение")
                return
            }
            
            DispatchQueue.main.async {
                self.posterView.image = image
            }
        }.resume()

    }
}
