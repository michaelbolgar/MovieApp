//
//  ViewBuilder.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import UIKit

final class ViewBuilder {
    
    // MARK: - Static Properties
    static let shared = ViewBuilder()
    
    // MARK: - Private Init
    private init() {}
    
    // MARK: - Public Methods
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 37.5
        imageView.clipsToBounds = true
        return imageView
    }
    
    func makeEditButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "editButton2"), for: .normal)
        button.backgroundColor = .customGrey
        button.layer.cornerRadius = 15
        button.tintColor = .customBlue
        button.layer.borderColor = UIColor.customBlack.cgColor
        button.layer.borderWidth = 2
        return button
    }
    
    func makeViewForTextField() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.customGrey.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 25
        return view
    }
    
    func makeTFLabel(with title: String) -> UILabel {
        let label = UILabel.makeLabel(
            text: title,
            font: UIFont.montserratMedium(ofSize: 12),
            textColor: .white,
            numberOfLines: 1
        )
        label.backgroundColor = .customBlack
        label.textAlignment = .center
        return label
    }
    
    func makeTextField(with placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textColor = .white
        textField.autocorrectionType = .no
        return textField
    }
    
    func makeSaveButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Save Changes", for: .normal)
        button.titleLabel?.font = UIFont.montserratMedium(ofSize: 16)
        button.tintColor = .white
        button.backgroundColor = .customBlue
        button.layer.cornerRadius = 30
        return button
    }
}



