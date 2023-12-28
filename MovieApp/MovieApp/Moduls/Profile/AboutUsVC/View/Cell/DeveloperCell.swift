//
//  DeveloperCell.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import UIKit

final class DeveloperCell: UICollectionViewCell {
    
    // MARK: - Static Properties
    static let reuseID = String(describing: DeveloperCell.self)
    
    // MARK: - Private UI Properties
    private lazy var mainImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var roleLabel: UILabel = {
        var label = UILabel.makeLabel(
            text: "Team Leader",
            font: .montserratSemiBold(ofSize: 14),
            textColor: .white,
            numberOfLines: 0
        )
        return label
    }()
    
    private lazy var githubImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "github")
        return imageView
    }()
    
    private lazy var githubLabel: UILabel = {
        var label = UILabel.makeLabel(
            text: "kirilloao",
            font: .montserratRegular(ofSize: 14),
            textColor: .white,
            numberOfLines: 1
        )
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with developer: Developer) {
        roleLabel.text = developer.role
        githubLabel.text = developer.githubLink
        mainImageView.image = UIImage(named: developer.image)
    }
}

// MARK: - Setup UI
private extension DeveloperCell {
    func setupCell() {
        backgroundColor = .customBlue
        layer.cornerRadius = 10
    }
    
    func setViews() {
        addSubviewsTamicOff(mainImageView,
                            roleLabel,
                            githubImageView,
                            githubLabel
        )
    }
    
    func setupConstraints() {
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(LayoutConstraints.mainImageTopOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(LayoutConstraints.mainImageSize)
            make.width.equalTo(LayoutConstraints.mainImageSize)
        }
        
        roleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom)
                .offset(LayoutConstraints.roleLabelTopOffset)
            make.centerX.equalToSuperview()
        }
        
        githubImageView.snp.makeConstraints { make in
            make.top.equalTo(roleLabel.snp.bottom)
                .offset(LayoutConstraints.githubImageTopOffset)
            make.leading.equalToSuperview()
                .offset(LayoutConstraints.edgePadding)
            make.height.equalTo(LayoutConstraints.githubImageSize)
            make.width.equalTo(LayoutConstraints.githubImageSize)
        }
        
        githubLabel.snp.makeConstraints { make in
            make.centerY.equalTo(githubImageView.snp.centerY)
            make.leading.equalTo(githubImageView.snp.trailing)
                .offset(LayoutConstraints.githubLabelLeadingOffset)
            make.trailing.equalToSuperview().offset(-LayoutConstraints.edgePadding)
        }
    }
    
    enum LayoutConstraints {
        static let mainImageTopOffset = 5
        static let mainImageSize = 80
        static let roleLabelTopOffset = 10
        static let githubImageTopOffset = 8
        static let githubImageSize = 20
        static let githubLabelLeadingOffset = 5
        static let edgePadding = 5
    }
}
