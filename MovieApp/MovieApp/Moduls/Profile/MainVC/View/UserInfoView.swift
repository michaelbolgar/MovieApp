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
//        imageView.layer.cornerRadius = 27
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
    
    // MARK: - Private Methods
    private func setViews() {
        self.addSubviewsTamicOff(profileImageView,
                                 userNameLabel,
                                 userEmailLabel,
                                 editButton
        )
    }
    
    private func setupMainView() {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.customGrey.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(56)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.left.equalTo(profileImageView.snp.right).offset(16)
        }
        
        userEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(8)
            make.left.equalTo(profileImageView.snp.right).offset(16)
            make.right.equalTo(editButton.snp.left).offset(-18)
        }
        
        editButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-19)
            make.top.equalToSuperview().offset(31)
            make.bottom.equalToSuperview().offset(-31)
            make.width.equalTo(24)
        }
    }
}
