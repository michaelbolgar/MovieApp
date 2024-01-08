//
//  SearchCell.swift
//  MovieApp
//
//  Created by Admin on 26.12.2023.
//

import UIKit
import SnapKit

class SearchCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier = String(describing: SearchCell.self)
    
    private let filmeImage:UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
        return element
    }()
    
    private let backgorundForRaitingView:UIView = {
        let element = UIView()
        element.layer.cornerRadius = 8
        element.backgroundColor = .gray
        element.alpha = 0.9
        return element
    }()
    
    private let starImage:UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "star")
        return element
    }()
    
    private let calenderImage:UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "calendar")
        element.tintColor = .customDarkGrey
        return element
    }()
    
    private let timeImage:UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "clock.fill")
        element.tintColor = .customDarkGrey
        return element
    }()
    
    private let ganreImage:UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "film.fill")
        element.tintColor = .customDarkGrey
        return element
    }()
    
    private let ratingLabel:UILabel = .makeLabel(font: UIFont.montserratMedium(ofSize: 14.5), textColor: .customOrange, numberOfLines: 1)
    
    private let filmNameLabel:UILabel = {
        let element = UILabel()
        element.font = UIFont.montserratSemiBold(ofSize: 16)
        element.textColor = .white
        element.numberOfLines = 2
        return element
    }()
    
    private let ageLimitLabel:UILabel = {
       let element = UILabel()
        element.font = UIFont.montserratMedium(ofSize: 12)
        element.textColor = .cyan
        element.numberOfLines = 1
        element.textAlignment = .center
        element.layer.cornerRadius = 3
        element.layer.borderWidth = 2
        element.layer.borderColor = UIColor.cyan.cgColor
        return element
    }()
    
    private let yearPublishedLabel:UILabel = .makeLabel(font: UIFont.montserratMedium(ofSize: 12), textColor: .customDarkGrey, numberOfLines: 1)
    
    private let timeLabel:UILabel = .makeLabel(font: UIFont.montserratMedium(ofSize: 12), textColor: .customDarkGrey, numberOfLines: 1)
    
    private let ganreLabel:UILabel = .makeLabel(font: UIFont.montserratMedium(ofSize: 12), textColor: .customDarkGrey, numberOfLines: 1)
    
    private let typeLabel:UILabel = .makeLabel(font: UIFont.montserratMedium(ofSize: 12), textColor: .white, numberOfLines: 1)
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .customGrey
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //FIXME: - Переделать когда будет готова сеть
    func configure(with model: SearchCellModel){
        filmeImage.image = model.image
        ratingLabel.text = model.rating
        filmNameLabel.text = model.name
        ageLimitLabel.text = model.ageLimit
        yearPublishedLabel.text = model.year
        timeLabel.text = model.time + " Minutes"
        ganreLabel.text = model.ganre + "  |"
        typeLabel.text = model.type
    }
    
    //MARK: - Methods
    private func setupViews() {
        [filmeImage, backgorundForRaitingView, starImage, filmNameLabel, yearPublishedLabel, timeLabel, ageLimitLabel, ganreLabel, typeLabel, calenderImage, timeImage, ganreImage].forEach { contentView.addSubview($0)}
        
        [starImage, ratingLabel].forEach { backgorundForRaitingView.addSubview($0)}
    }
    
    private func setupConstraints() {
        
        filmeImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(24)
            make.width.equalTo(112)
        }
        
        backgorundForRaitingView.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(24)
            make.top.equalTo(filmeImage.snp.top).offset(8)
            make.leading.equalTo(filmeImage.snp.leading).inset(8)
        }
        
        starImage.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalTo(backgorundForRaitingView).offset(8)
            make.centerY.equalTo(backgorundForRaitingView)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(starImage.snp.trailing).offset(4)
            make.centerY.equalTo(backgorundForRaitingView)
        }
        
        filmNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalTo(filmeImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(12)
        }
        
        calenderImage.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalTo(filmNameLabel)
            make.top.equalTo(filmNameLabel.snp.bottom).offset(12)
        }
        
        yearPublishedLabel.snp.makeConstraints { make in
            make.leading.equalTo(calenderImage.snp.trailing).offset(4)
            make.centerY.equalTo(calenderImage)
        }
        
        timeImage.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalTo(calenderImage)
            make.top.equalTo(calenderImage.snp.bottom).offset(14)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(timeImage.snp.trailing).offset(4)
            make.centerY.equalTo(timeImage)
        }
        
        ageLimitLabel.snp.makeConstraints { make in
            make.leading.equalTo(timeLabel.snp.trailing).offset(12)
            make.centerY.equalTo(timeLabel)
        }
        
        ganreImage.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalTo(timeImage)
            make.top.equalTo(timeImage.snp.bottom).offset(14)
        }
        
        ganreLabel.snp.makeConstraints { make in
            make.leading.equalTo(ganreImage.snp.trailing).offset(4)
            make.centerY.equalTo(ganreImage)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ganreImage)
            make.leading.equalTo(ganreLabel.snp.trailing).offset(8)
        }
    }
}
