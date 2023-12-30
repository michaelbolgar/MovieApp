//
//  PlugView.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 29.12.2023.
//

import UIKit

final class PlugView: UIView {
    
    // MARK: - Private UI Properties
    private lazy var boxImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "box")
        return imageView
    }()
    
    private lazy var firstInfoLabel: UILabel = {
        var label = UILabel.makeLabel(
            text: "There Is No Movie Yet!",
            font: .montserratSemiBold(ofSize: 17),
            textColor: .white,
            numberOfLines: 1
        )
        label.textAlignment = .center
        return label
    }()
    
    private lazy var secondInfoLabel: UILabel = {
        var label = UILabel.makeLabel(
            text: "Find your movie by Type title, categories, years, etc",
            font: .montserratMedium(ofSize: 13),
            textColor: .customLightGrey,
            numberOfLines: 2
        )
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setViews() {
        [boxImageView, firstInfoLabel, secondInfoLabel].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        boxImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(LayoutConstraint.boxImageSize)
            make.height.equalTo(LayoutConstraint.boxImageSize)
            make.centerX.equalToSuperview()
        }
        
        firstInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(boxImageView.snp.bottom)
                .offset(LayoutConstraint.infoLabelTopOffset)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        secondInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(firstInfoLabel.snp.bottom)
                .offset(LayoutConstraint.infoLabelTopOffset)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private enum LayoutConstraint {
        static let boxImageSize: CGFloat = 76
        static let infoLabelTopOffset: CGFloat = 10
    }
}
