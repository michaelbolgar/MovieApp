//
//  UserInfoView.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 25.12.2023.
//

import UIKit

final class UserInfoView: UIView {
    
    // MARK: - Closures
    var editButtonTap: (() -> Void)?
    
    // MARK: - Private UI Properties
    private lazy var profileImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        var label = UILabel.makeLabel(
            text: "Kirill",
            font: UIFont.montserratSemiBold(ofSize: 16),
            textColor: .white,
            numberOfLines: 1
        )
        return label
    }()
    
    private lazy var userEmailLabel: UILabel = {
        var label = UILabel.makeLabel(
            text: "taraturin.kirill.dev@gmail.com",
            font: UIFont.montserratMedium(ofSize: 14),
            textColor: UIColor.lightGray,
            numberOfLines: 1
        )
        return label
    }()
    
    private lazy var editButton: UIButton = {
        var button = UIButton(type: .system)
        let editImage = UIImage(named: "editButton")
        button.setImage(editImage, for: .normal)
        button.tintColor = .customBlue
        button.addTarget(
            self,
            action: #selector(editButtonDidTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMainView()
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    // MARK: - Public Methods
    func setViews(with user: User) {
        profileImageView.image = UIImage(data: user.image)
        userNameLabel.text = user.fullName
        userEmailLabel.text = user.email
    }
    
    // MARK: - Private Actions
    @objc private func editButtonDidTapped() {
        editButtonTap?()
    }
}

// MARK: - Setup UI
private extension UserInfoView {
    func setViews() {
        [profileImageView, userNameLabel, userEmailLabel, editButton]
            .forEach { self.addSubview($0) }
    }
    
    func setupMainView() {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.customGrey.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(LayoutConstraints.profileImageTopBottomOffset)
            make.left.equalToSuperview()
                .offset(LayoutConstraints.profileImageTopBottomOffset)
            make.bottom.equalToSuperview()
                .offset(-LayoutConstraints.profileImageTopBottomOffset)
            make.width.equalTo(LayoutConstraints.profileImageWidth)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(LayoutConstraints.userNameTopOffset)
            make.left.equalTo(profileImageView.snp.right)
                .offset(LayoutConstraints.labelsLeftOffset)
        }
        
        userEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom)
                .offset(LayoutConstraints.userEmailTopOffset)
            make.left.equalTo(profileImageView.snp.right)
                .offset(LayoutConstraints.labelsLeftOffset)
            make.right.equalTo(editButton.snp.left)
                .offset(-LayoutConstraints.labelsLeftOffset)
        }
        
        editButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
                .offset(LayoutConstraints.editButtonRightOffset)
            make.top.equalToSuperview()
                .offset(LayoutConstraints.editButtonTopBottomOffset)
            make.bottom.equalToSuperview()
                .offset(-LayoutConstraints.editButtonTopBottomOffset)
            make.width.equalTo(LayoutConstraints.editButtonWidth)
        }
    }
    
    enum LayoutConstraints {
        static let profileImageTopBottomOffset = 16
        static let profileImageWidth = 56
        
        static let userNameTopOffset = 21
        static let userEmailTopOffset = 8
        static let labelsLeftOffset = 16
        
        static let editButtonRightOffset = -19
        static let editButtonTopBottomOffset = 31
        static let editButtonWidth = 24
    }
}
