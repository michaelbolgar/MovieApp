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
        SettingView(title: "", imageName: "")
    }()
    
    private lazy var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = .customGrey
        return view
    }()
    
    private lazy var secondSettingView: SettingView = {
        SettingView(title: "", imageName: "")
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
    
    private func setViews() {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.customGrey.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        
        self.addSubview(titleLabel)
        self.addSubview(firstSettingView)
        self.addSubview(lineView)
        self.addSubview(secondSettingView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(15)
        }
        
        firstSettingView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(firstSettingView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(1)
        }
        
        secondSettingView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
    }
}
