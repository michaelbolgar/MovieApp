//
//  WishlistCell.swift
//  MovieApp
//
//  Created by Admin on 26.12.2023.
//

import UIKit

final class WishlistCell: UITableViewCell {
    
    // MARK: - Static Properties
    static let identifier = String(describing: WishlistCell.self)
    
    // MARK: - Private UI Properties
    private let backgroundForView: UIView = {
        let element = UIView()
        element.backgroundColor = .customGrey
        element.layer.cornerRadius = 16
        return element
    }()
    
    private let filmeImage: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.layer.cornerRadius = 8
        element.clipsToBounds = true
        return element
    }()
    
    private let starImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "star")
        return element
    }()
    
    private let heartImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "heart.fill")
        element.tintColor = .red
        return element
    }()
    
    private let playImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "playGroup")
        return element
    }()
    
    private let ganreLabel =  {
        UILabel.makeLabel(
            font: UIFont.montserratMedium(ofSize: 12),
            textColor: .customWhiteGrey,
            numberOfLines: 1
        )
    }()
    
    private let typeFilmeLabel =  {
        UILabel.makeLabel(
            font: UIFont.montserratMedium(ofSize: 12),
            textColor: .customDarkGrey,
            numberOfLines: 1
        )
    }()
    
    private let ratingLabel = {
        UILabel.makeLabel(
            font: UIFont.montserratMedium(ofSize: 14.5),
            textColor: .customOrange,
            numberOfLines: 1
        )
    }()
    
    private let filmNameLabel:UILabel = {
        let element = UILabel()
        element.font = UIFont.montserratSemiBold(ofSize: 16)
        element.textColor = .white
        element.numberOfLines = 2
        return element
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    //FIXME: - Переделать когда будет готова сеть
    func configure(with model:Movie){
        filmeImage.image = UIImage(data: model.image)
        ganreLabel.text = model.ganre
        filmNameLabel.text = model.name
        typeFilmeLabel.text = model.type
        ratingLabel.text = model.rating
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        contentView.addSubview(backgroundForView)
        [
            filmeImage, playImage, ganreLabel, filmNameLabel, typeFilmeLabel,
            starImage, ratingLabel, heartImage
        ].forEach{backgroundForView.addSubview($0)}
    }
    
    private func setupConstraints() {
        backgroundForView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
            make.trailing.leading.equalToSuperview().inset(24)
//            make.height.equalTo(107)
        }
        
        filmeImage.snp.makeConstraints { make in
//            make.top.equalTo(backgroundForView.snp.top).inset(12)
//            make.top.equalToSuperview().offset(12)
//            make.leading.equalTo(backgroundForView.snp.leading).inset(12)
            make.leading.equalToSuperview().offset(12)
            make.top.bottom.equalToSuperview().inset(12)
//            make.bottom.equalTo(backgroundForView.snp.bottom).inset(12)
            make.width.equalTo(121)
        }
        
        playImage.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.center.equalTo(filmeImage)
        }
        
        ganreLabel.snp.makeConstraints { make in
//            make.top.equalTo(backgroundForView.snp.top).inset(13)
            make.top.equalToSuperview().offset(13)
            make.leading.equalTo(filmeImage.snp.trailing).offset(16)
        }
        
        filmNameLabel.snp.makeConstraints { make in
            make.top.equalTo(ganreLabel.snp.bottom).offset(8)
            make.trailing.equalTo(backgroundForView).inset(12)
            make.leading.equalTo(ganreLabel)
        }
        
        typeFilmeLabel.snp.makeConstraints { make in
            make.top.equalTo(filmNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(filmNameLabel)
        }
        
        starImage.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalTo(typeFilmeLabel.snp.trailing).offset(8)
            make.centerY.equalTo(typeFilmeLabel)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(starImage.snp.trailing).offset(4)
            make.centerY.equalTo(starImage)
        }
        
        heartImage.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundForView).inset(12)
            make.trailing.equalTo(backgroundForView).inset(12)
        }
    }
}

//FIXME: 
//struct WishlistCellModel{
//    let image: UIImage
//    let ganre: String
//    let name: String
//    let type: String
//    let rating: String
//}
