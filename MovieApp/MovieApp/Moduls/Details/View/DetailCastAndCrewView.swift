//
//  CastAndCrewView.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 04.01.24.
//

import UIKit

// MARK: - DetailCastAndCrewView
final class DetailCastAndCrewView: UIView {

    // MARK: - Properties
    private lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = LayoutConstants.avatarSize / 2
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    private let name = UILabel.makeLabel(
            text: "",
            font: UIFont.montserratSemiBold(ofSize: LayoutConstants.fontSize),
            textColor: .white,
            numberOfLines: 1)

        private let profession = UILabel.makeLabel(
            text: "",
            font: UIFont.montserratSemiBold(ofSize: 13),
            textColor: .customLightGrey,
            numberOfLines: 1)

    // TODO: - NEED REMOVE TEXTSTACK
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
                LayoutConstants.textLeadingOffset
            )
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(avatar)
        }
        avatar.snp.makeConstraints {
            $0.width.height.equalTo(LayoutConstants.avatarSize)
            $0.leading.equalToSuperview().inset(25)
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
        
        guard let imageURL = model.imageURL, let url = URL(string: imageURL) else {
            avatar.image = nil
            return
        }
        
        ImageDownloader.shared.downloadImage(from: url) { result in
            switch result {
            case .success(let image):
                self.avatar.image = image
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Constants
private enum LayoutConstants {
    static let avatarSize: CGFloat = 40
    static let professionFontSize: CGFloat = 10
    static let textLeadingOffset = 10
    static let fontSize: CGFloat = 15
}
