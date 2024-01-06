//
//  SectionHeaderView.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 05.01.24.
//

import UIKit

// MARK: - Constants

private enum Titles {
    static let fatalError = "init(coder:) has not been implemented"
}

// MARK: - SectionHeaderView

class SectionHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    let titleLabel: UILabel = {
        let label = UILabel.makeLabel(
            font: .montserratSemiBold(ofSize: 16),
            textColor: .white,
            numberOfLines: 1
        )
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(Titles.fatalError)
    }
    
    // MARK: - Setup
    private func setupViews() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-16)
            make.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Configuration
    func configure(with title: String) {
        titleLabel.text = title
    }
}


