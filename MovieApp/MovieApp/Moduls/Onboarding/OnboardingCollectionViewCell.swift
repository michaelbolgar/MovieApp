//
//  OnboardingCollectionViewCell.swift
//  MovieApp
//
//  Created by Мой Macbook on 10.01.2024.
//

import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    //MARK: - Properties
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        backgroundColor = .customBlack
        addSubview(backgroundImageView)
    }
    
    public func cellConfigure(model: OnboardingStruct) {
        backgroundImageView.image = model.image
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
        ])
    }
}
