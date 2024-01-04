//
//  CastAndCrewView.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 04.01.24.
//

import UIKit
//import Kingfisher

private enum Titles {
    static let avatarSize: CGFloat = 40
}

final class CastAndCrewView: UIView {
    
    private lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Titles.avatarSize / 2
        image.clipsToBounds = true
        return image
    }()
    private lazy var name: UILabel = {
        let label = UILabel.makeLabel(
            text: "",
            font: UIFont.montserratSemiBold(ofSize: 14),
            textColor: .white,
            numberOfLines: 1)
        return label
    }()
    private lazy var profession: UILabel = {
        let label = UILabel.makeLabel(
            text: "",
            font: UIFont.montserratSemiBold(ofSize: 10),
            textColor: UIColor.customGrey,
            numberOfLines: 1)
        return label
    }()
    private lazy var textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        setupConstraints()
    }
    
    private func setupConstraints() {
        textStack.snp.makeConstraints {
            $0.leading.equalTo(avatar.snp.trailing).offset(10)
            $0.centerY.equalTo(avatar)
        }
        avatar.snp.makeConstraints {
            $0.width.height.equalTo(Titles.avatarSize)
            $0.trailing.equalTo(5)
            $0.centerY.equalToSuperview()
        }
    }
    private func configure() {
        addSubview(textStack)
        addSubview(avatar)
        
        [name, profession].forEach { textStack.addArrangedSubview($0) }
    }
}

extension CastAndCrewView: Configurable {
    
    struct Model {
        let imageURL: URL?
        let name: String?
        let profession: String?
    }
    
    func update(model: Model) {
        name.text = model.name
        profession.text = model.profession
        
        guard let imageURL = model.imageURL else {
            avatar.image = nil
            return
        }
        // Асинхронная загрузка изображения
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
                   self.avatar.image = image
               }
           }.resume()
    }
}
