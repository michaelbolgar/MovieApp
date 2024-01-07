//
//  CatergoriesSectionView.swift
//  MovieApp
//
//  Created by Admin on 29.12.2023.
//

import UIKit
import SnapKit

class CatergoriesSectionView: UIView {
    
    // MARK: - UI Properties
#warning("почему не использовать тут UILabel.makeLabel() ? ")
    let titleLabel:UILabel = {
        let element = UILabel()
        element.textAlignment = .left
        element.font = UIFont.montserratSemiBold(ofSize: 16)
        element.textColor = .white
        element.numberOfLines = 1
        return element
    }()
    
    let seeAllButton: UIButton = {
        let element = UIButton()
        element.setTitle("See all", for: .normal)
        element.setTitleColor(.customBlue, for: .normal)
        element.titleLabel?.font = UIFont.montserratRegular(ofSize: 14)
        return element
    }()
    
    // MARK: - Init
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        self.backgroundColor = .clear
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupViews(){
        [titleLabel, seeAllButton].forEach { self.addSubview($0) }
    }
    
    private func setupConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(24)
        }
    }
    
}
