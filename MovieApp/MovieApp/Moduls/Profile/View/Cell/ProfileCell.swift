//
//  ProfileCell.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 25.12.2023.
//

import UIKit

final class ProfileCell: UITableViewCell {
    
    // MARK: - Static Properties
    static let reuseID = String(describing: ProfileVC.self)
    
    // MARK: - Private UI Properties
    private lazy var profileView: UIView = {
        var view = makeView()
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 25
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
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setViews() {
        contentView.addSubviewsTamicOff(profileView)
        profileView.addSubviewsTamicOff(profileImageView,
                                        userNameLabel,
                                        userEmailLabel,
                                        editButton
        )
    }
    
    private func setupConstraints() {
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(54)
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
    
    // MARK: - Make UI Methods
    private func makeView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.customGrey.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 15
        return view
    }
    
}
