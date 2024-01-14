//
//  FooterCell.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 13.01.2024.
//

import UIKit

final class FooterCell: UICollectionReusableView {
    
    // MARK: - Private UI Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratRegular(ofSize: 15)
        label.textColor = .white
        label.text = """
The app was developed by team №2 as part of the SwiftMarathonX by Devrash, with questions and suggestions please contact via email movie.app@gmail.com
"""
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}
