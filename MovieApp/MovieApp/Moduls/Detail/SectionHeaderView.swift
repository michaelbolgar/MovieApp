//
//  SectionHeaderView.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 05.01.24.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "section-header-reuse-identifier"
    
    let titleLabel: UILabel = {
        let label = UILabel.makeLabel(font: .montserratSemiBold(ofSize: 16), textColor: .white, numberOfLines: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-16)
            make.top.bottom.equalToSuperview()
        }
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}


