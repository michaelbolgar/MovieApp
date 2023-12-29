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
        UILabel.makeLabel(
            text: "English",
            font: .montserratSemiBold(ofSize: 16),
            textColor: .white,
            numberOfLines: 1
        )
    }()
    
    private var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = .customGrey
        return view
    }()
    
    private let checkmarkImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")?
            .withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .customBlue
        imageView.isHidden = true
        return imageView
    }()
    
    // MARK: - Private Properties
    private var isChecked = false {
        didSet {
            checkmarkImageView.isHidden = !isChecked
        }
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with language: String) {
        mainLabel.text = language
    }
    
    func setCheckmarkValue(_ value: Bool) {
        isChecked = value
    }
}

// MARK: - Setup UI
private extension LanguageCell {
    func setViews() {
        selectionStyle = .none
        backgroundColor = .clear
        [mainLabel, lineView, checkmarkImageView].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
                .offset(LayoutConstraints.mainLabelLeftOffset)
            make.centerY.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(LayoutConstraints.lineViewHeight)
            make.leading.trailing.equalToSuperview()
                .inset(LayoutConstraints.horizontalInset)
        }
        
        checkmarkImageView.snp.makeConstraints { make in
            make.centerY.equalTo(mainLabel.snp.centerY)
            make.right.equalToSuperview()
                .offset(LayoutConstraints.checkmarkRightOffset)
        }
    }
    
    enum LayoutConstraints {
        static let mainLabelLeftOffset: CGFloat = 35
        static let lineViewHeight: CGFloat = 1
        static let horizontalInset: CGFloat = 20
        static let checkmarkRightOffset: CGFloat = -25
    }
}


