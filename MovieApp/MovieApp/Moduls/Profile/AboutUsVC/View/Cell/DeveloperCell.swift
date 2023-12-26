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
        label.isUserInteractionEnabled = true
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .customBlue
        layer.cornerRadius = 10
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
    
    // MARK: - Private Methods
    private func setViews() {
        addSubviewsTamicOff(mainImageView,
                            roleLabel,
                            githubImageView,
                            githubLabel
        )
    }
    
    private func setupConstraints() {
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        
        roleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        githubImageView.snp.makeConstraints { make in
            make.top.equalTo(roleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        githubLabel.snp.makeConstraints { make in
            make.centerY.equalTo(githubImageView.snp.centerY)
            make.leading.equalTo(githubImageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
}
