//
//  CatergoriesSectionView.swift
//  MovieApp
//
//  Created by Admin on 29.12.2023.
//

import UIKit

final class CatergoriesSectionView: UIView {
    
    // MARK: - Closures
    var seeAllButtonTapped: (() -> Void)?
    
    // MARK: - UI Properties
    private let titleLabel = UILabel.makeLabel(text: "", font: UIFont.montserratSemiBold(ofSize: 16), textColor: .white, numberOfLines: 1)
    
    private let seeAllButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("See all", for: .normal)
        element.setTitleColor(.customBlue, for: .normal)
        element.titleLabel?.font = UIFont.montserratRegular(ofSize: 14)
        element.addTarget(
            self,
            action: #selector(seeAllButtonDidTapped),
            for: .touchUpInside
        )
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
    
    // MARK: - Private Actions
    @objc private func seeAllButtonDidTapped() {
        seeAllButtonTapped?()
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
