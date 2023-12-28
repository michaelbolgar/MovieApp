//
//  SettingView.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 25.12.2023.
//

import UIKit

final class SettingView: UIView {
    
    // MARK: - Private Properties
    private var title: String!
    private var imageName: String!
    
    // MARK: - Private UI Properties
    private var iconView: UIView!
    private var nameLabel: UILabel!
    
    private lazy var arrowView: UIView = {
        let arrowView = UIImageView(image: UIImage(named: "arrow"))
        arrowView.tintColor = .customBlue
        return arrowView
    }()
    
    // MARK: - Init
    init(title: String) {
        super.init(frame: .zero)
        configure(title: title)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(title: String) {
        self.title = title
        self.imageName = title
        
        iconView = createIconView(with: title)
        
        nameLabel = UILabel.makeLabel(
            text: title,
            font: UIFont.montserratMedium(ofSize: 15),
            textColor: .white,
            numberOfLines: 1
        )
        
        setViews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func createIconView(with imageName: String) -> UIView {
        let view = UIView()
        view.backgroundColor = .customGrey
        view.layer.cornerRadius = 17.5
        
        if !imageName.isEmpty {
            let imageView = UIImageView(image: UIImage(named: imageName))
            view.addSubview(imageView)
            
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(6)
            }
        } else {
            
        }
        return view
    }
}

// MARK: - Setup UI
private extension SettingView {
    func setViews() {
        addSubviewsTamicOff(iconView,
                            nameLabel,
                            arrowView
        )
    }
    
    func setupConstraints() {
        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(LayoutConstraints.iconWidth)
            make.left.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconView.snp.right)
                .offset(LayoutConstraints.nameLabelLeftOffset)
            make.right.equalTo(arrowView.snp.left)
                .offset(-LayoutConstraints.nameLabelRightOffset)
        }
        
        arrowView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(LayoutConstraints.arrowWidth)
        }
    }
    
    enum LayoutConstraints {
        static let iconWidth = 35
        static let arrowWidth = 30
        static let nameLabelLeftOffset = 20
        static let nameLabelRightOffset = 50
    }
}


