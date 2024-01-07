//
//  PopularCategoryCell.swift
//  MovieApp
//
//  Created by Admin on 26.12.2023.
//

import UIKit
import SnapKit

class PopularCategoryCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = String(describing: PopularCategoryCell.self)
    
    private let backgorundForRaitingView:UIView = {
        let element = UIView()
        element.layer.cornerRadius = 8
        element.backgroundColor = .gray
        element.alpha = 0.9
        return element
    }()
    
    private let filmeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let starForRaitingImage:UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "star")
        return element
    }()
    
    private let nameFilmLabel:UILabel = {
        let element = UILabel()
        element.font = UIFont.montserratSemiBold(ofSize: 14)
        element.textColor = .white
        element.numberOfLines = 1
        return element
    }()
    
    private let ganreFilmLabel:UILabel = .makeLabel(font: UIFont.montserratRegular(ofSize: 10), textColor: .customLightGrey, numberOfLines: 1)
    
    private let ratingFilmLabel:UILabel = .makeLabel(font: UIFont.montserratMedium(ofSize: 12), textColor: .customOrange, numberOfLines: 1)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .customGrey
        contentView.layer.cornerRadius = 12
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupViews() {
        [filmeImage, backgorundForRaitingView, nameFilmLabel, ganreFilmLabel].forEach { contentView.addSubview($0) }
        
        [starForRaitingImage, ratingFilmLabel].forEach { backgorundForRaitingView.addSubview($0) }
    }
    
    //FIXME: - Переделать когда будет готова сеть
    func configure(with model:PopularCategoryMovieCellModel){
        filmeImage.image = model.image
        nameFilmLabel.text = model.name
        ganreFilmLabel.text = model.ganre
        ratingFilmLabel.text = model.rating
    }
    
    private func setupConstraints(){
        filmeImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(53)
        }
        
        nameFilmLabel.snp.makeConstraints { make in
            make.top.equalTo(filmeImage.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        ganreFilmLabel.snp.makeConstraints { make in
            make.top.equalTo(nameFilmLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        backgorundForRaitingView.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(24)
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        starForRaitingImage.snp.makeConstraints { make in
            make.leading.equalTo(backgorundForRaitingView).offset(8)
            make.centerY.equalTo(backgorundForRaitingView)
        }
        
        ratingFilmLabel.snp.makeConstraints { make in
            make.leading.equalTo(starForRaitingImage.snp.trailing).offset(4)
            make.trailing.equalTo(backgorundForRaitingView).inset(8)
            make.centerY.equalTo(backgorundForRaitingView)
        }
        
    }
    
}

//FIXME: 
struct PopularCategoryMovieCellModel {
    let image:UIImage?
    let name:String
    let ganre:String
    let rating:String
}
