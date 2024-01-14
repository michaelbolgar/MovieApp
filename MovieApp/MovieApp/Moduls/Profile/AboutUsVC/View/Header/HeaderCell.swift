//
//  HeaderCell.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 13.01.2024.
//

import UIKit

final class HeaderCell: UICollectionReusableView {
    
    // MARK: - Private UI Properties
    private lazy var devrushImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "devrush")
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(ofSize: 17)
        label.textColor = .white
        label.text = "SwiftMarathonX Challenge 3"
        label.textAlignment = .center
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        devrushImageView.layer.cornerRadius = devrushImageView.frame.width / 2
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(devrushImageView)
        
        devrushImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(devrushImageView.snp.trailing).offset(0)
            make.trailing.equalToSuperview().offset(-30)
            make.centerY.equalToSuperview()
        }
    }
    
}
