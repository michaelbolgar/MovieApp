//
//  CategoriesCell.swift
//  MovieApp
//
//  Created by Admin on 30.12.2023.
//

import UIKit

protocol CategoriesCellProtocol {
    func configure(with title: String)
    func selectCell()
    func deselectCell()
}

class CategoriesCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    private let headerLabel:UILabel = {
        let element = UILabel()
        element.font = UIFont.montserratMedium(ofSize: 12)
        element.textColor = .white
        element.numberOfLines = 1
        element.textAlignment = .center
        element.minimumScaleFactor = 0.1
        element.adjustsFontSizeToFitWidth = true
        return element
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(with title: String){
        headerLabel.text = title
    }
    
    func selectCell(){
        headerLabel.textColor = .customBlue
        contentView.backgroundColor = .customLightGrey
    }
    
    func deselectCell(){
        headerLabel.textColor = .white
        contentView.backgroundColor = .clear
    }
    
    private func setupViews(){
        addSubview(headerLabel)
    }
    
    private func setupConstraints(){
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
