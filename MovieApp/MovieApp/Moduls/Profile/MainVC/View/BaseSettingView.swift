//
//  BaseSettingView.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 25.12.2023.
//

import UIKit

class BaseSettingView: UIView {
    
    // MARK: - Closures
    var onFirstSetttingTap: (() -> Void)?
    var onSecondSetttingTap: (() -> Void)?
    
    // MARK: - Private UI Properties
    private lazy var titleLabel: UILabel = {
        var label = UILabel.makeLabel(
            text: "",
            font: UIFont.montserratSemiBold(ofSize: 18),
            textColor: .white,
            numberOfLines: 1
        )
        return label
    }()
    
    private lazy var firstSettingView: SettingView = {
        SettingView(title: "")
    }()
    
    private lazy var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = .customGrey
        return view
    }()
    
    private lazy var secondSettingView: SettingView = {
        SettingView(title: "")
    }()
    
    // MARK: - Init
    init(
        frame: CGRect,
        title: String,
        firstSettingTitle: String,
        secondSettingTitle: String
    )
    {
        super.init(frame: frame)
        
        titleLabel.text = title
        
        firstSettingView.configure(title: firstSettingTitle)
        secondSettingView.configure(title: secondSettingTitle)
        
        setViews()
        setupConstraints()
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Actions
    @objc private func firstSettingTapped() {
        onFirstSetttingTap?()
    }
    
    @objc private func secondSettingTapped() {
        onSecondSetttingTap?()
    }
    
    // MARK: - Private Methods
    private func addTapGesture() {
        let firstTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(firstSettingTapped)
        )
        firstSettingView.addGestureRecognizer(firstTapGesture)
        firstSettingView.isUserInteractionEnabled = true
        
        let secondTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(secondSettingTapped)
        )
        secondSettingView.addGestureRecognizer(secondTapGesture)
        secondSettingView.isUserInteractionEnabled = true
    }
}

// MARK: - Setup UI
private extension BaseSettingView {
    func setViews() {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.customGrey.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        
        [titleLabel, firstSettingView, lineView, secondSettingView]
            .forEach { self.addSubview($0)}
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(LayoutConstraints.titleTopLeftOffset)
            make.left.equalToSuperview()
                .offset(LayoutConstraints.titleTopLeftOffset)
        }
        
        firstSettingView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
                .offset(LayoutConstraints.settingsTopOffset)
            make.left.equalToSuperview()
                .offset(LayoutConstraints.settingsLeftRightOffset)
            make.right.equalToSuperview()
                .offset(-LayoutConstraints.settingsLeftRightOffset)
            make.height.equalTo(LayoutConstraints.settingsHeight)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(firstSettingView.snp.bottom)
                .offset(LayoutConstraints.lineTopOffset)
            make.left.equalToSuperview()
                .offset(LayoutConstraints.lineLeftRightOffset)
            make.right.equalToSuperview()
                .offset(-LayoutConstraints.lineLeftRightOffset)
            make.height.equalTo(LayoutConstraints.lineHeight)
        }
        
        secondSettingView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
                .offset(LayoutConstraints.settingsTopOffset)
            make.left.equalToSuperview()
                .offset(LayoutConstraints.settingsLeftRightOffset)
            make.right.equalToSuperview()
                .offset(-LayoutConstraints.settingsLeftRightOffset)
            make.height.equalTo(LayoutConstraints.settingsHeight)
        }
    }
    
    enum LayoutConstraints {
        static let titleTopLeftOffset = 15
        static let settingsTopOffset = 20
        static let settingsLeftRightOffset = 20
        static let settingsHeight = 35
        static let lineTopOffset = 20
        static let lineLeftRightOffset = 30
        static let lineHeight = 1
    }
}
