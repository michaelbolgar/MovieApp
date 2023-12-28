//
//  LanguageCell.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 28.12.2023.
//

import UIKit

final class LanguageCell: UITableViewCell {
    
    // MARK: - Static Properties
    static let reuseID = String(describing: LanguageCell.self)
    
    // MARK: - Private UI Properties
    private lazy var mainLabel: UILabel = {
        var label = UILabel.makeLabel(
            text: "English",
            font: .montserratSemiBold(ofSize: 17),
            textColor: .white,
            numberOfLines: 1
        )
        return label
    }()
    
    private lazy var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = .customGrey
        return view
    }()
    
    private let checkmarkImageVIew = UIImageView()
    
    var isChecked = false {
        didSet {
            checkmarkImageVIew.isHidden = !isChecked
        }
    }
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setupConstraints()
        
        
        checkmarkImageVIew.image = UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate)
        checkmarkImageVIew.tintColor = .customBlue
        
        addSubview(checkmarkImageVIew)
        
        checkmarkImageVIew.snp.makeConstraints { make in
            make.centerY.equalTo(mainLabel.snp.centerY)
            make.right.equalToSuperview().offset(-25)
        }
        
        checkmarkImageVIew.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with language: String) {
        mainLabel.text = language
    }
    
    // MARK: - Private Methods
    private func setViews() {
        addSubview(mainLabel)
        addSubview(lineView)
    }

    private func setupConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35)
            make.centerY.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
}


