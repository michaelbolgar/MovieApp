//
//  CastAndCrewView.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 04.01.24.
//

import UIKit

// MARK: - Constants
private enum Titles {
    static let avatarSize: CGFloat = 40
    static let nameFontSize: CGFloat = 14
    static let professionFontSize: CGFloat = 10
    static let numberOfLines = 1
    static let textLeadingOffset = 10
}

// MARK: - DetailCastAndCrewView
final class DetailCastAndCrewView: UIView {
    
    // MARK: - Properties
    private lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Titles.avatarSize / 2
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    private lazy var name: UILabel = {
        let label = UILabel.makeLabel(
            text: "",
            font: UIFont.montserratSemiBold(ofSize: Titles.nameFontSize),
            textColor: .white,
            numberOfLines: Titles.numberOfLines)
        return label
    }()
    private lazy var profession: UILabel = {
        let label = UILabel.makeLabel(
            text: "",
            font: UIFont.montserratSemiBold(ofSize: Titles.professionFontSize),
            textColor: .white,
            numberOfLines: Titles.numberOfLines)
        return label
    }()
    private lazy var textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        return stack
    }()
    
    // MARK: - Initialization
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
    
    // MARK: - Layout
    private func setupConstraints() {
        textStack.snp.makeConstraints {
            $0.leading.equalTo(
                avatar.snp.trailing
            ).offset(
                Titles.textLeadingOffset
            )
            $0.centerY.equalTo(avatar)
        }
        avatar.snp.makeConstraints {
            $0.width.height.equalTo(Titles.avatarSize)
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    private func configure() {
        addSubview(textStack)
        addSubview(avatar)
        
        [name, profession].forEach { textStack.addArrangedSubview($0) }
    }
}

// MARK: - DetailCastAndCrewView+Configurable
extension DetailCastAndCrewView: Configurable {
    
    struct Model {
//        let imageURL: URL?
        let imageURL: String?
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
//           URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
//               guard let self = self else { return }
//               
//               if let error = error {
//                   // Обработка ошибки загрузки
//                   print("Ошибка загрузки изображения: \(error.localizedDescription)")
//                   return
//               }
//               
//               guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                   print("Некорректный ответ сервера")
//                   return
//               }
//               
//               guard let data = data, let image = UIImage(data: data) else {
//                   print("Данные не могут быть преобразованы в изображение")
//                   return
//               }
//               
//               DispatchQueue.main.async {
//                   self.avatar.image = image
//               }
//           }.resume()
        avatar.image = UIImage(named: "creator")
    }
}
