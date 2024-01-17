//
//  CategoriesCell.swift
//  MovieApp
//
//  Created by Admin on 30.12.2023.
//

import UIKit

protocol CategoriesCellProtocol {
    func configure(with model: CatergoriesModel)
    func selectCell()
    func deselectCell()
}

final class CategoriesCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    static let identifier = String(describing: CategoriesCell.self)
    
    // MARK: - Private UI Properties
    private let nameCategoieLabel:UILabel = {
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
    
    // MARK: - Methods
    private func setupViews() {
        self.layer.cornerRadius = 8
        addSubview(nameCategoieLabel)
    }
    
    private func setupConstraints() {
        nameCategoieLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - CategoriesCellProtocol
extension CategoriesCell: CategoriesCellProtocol {
    
    func configure(with model: CatergoriesModel) {
        nameCategoieLabel.text = model.name
    }
    
    func selectCell() {
        self.backgroundColor = .customGrey
        nameCategoieLabel.textColor = .customBlue
    }
    
    func deselectCell() {
        nameCategoieLabel.textColor = .white
        self.backgroundColor = .clear
    }
}

struct CatergoriesModel{
    let name:String
}
