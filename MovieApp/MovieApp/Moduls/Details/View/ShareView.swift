//
//  ShareView.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 11.01.24.
//

import UIKit

// Класс для представления всплывающего окна с кнопками поделиться
class ShareView: UIView {
    
    let facebookButton = UIButton()
    let instagramButton = UIButton()
    let twitterButton = UIButton()
    let closeButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        // Настройка внешнего вида и добавление кнопок на ShareView
        self.backgroundColor = .white
        self.layer.cornerRadius = 16

        // Добавление и настройка кнопки закрытия
        closeButton.setTitle("X", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        // Добавление кнопок на view
        let stackView = UIStackView(arrangedSubviews: [facebookButton, instagramButton, twitterButton, closeButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    @objc private func closeButtonTapped() {
        self.removeFromSuperview()
    }
}
