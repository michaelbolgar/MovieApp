//
//  EditProfileVC.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import UIKit

protocol EditProfileVCProtocol: AnyObject {
    
}

final class EditProfileVC: UIViewController {
    
    // MARK: - Presenter
    var presenter: EditProfilePresenterProtocol!
    
    // MARK: - ViewBuilder
    private let viewBuilder = ViewBuilder.shared
    
    // MARK: - Private UI Properties
    private lazy var userImageView = { viewBuilder.makeImageView() }()
    private lazy var editButton = { viewBuilder.makeEditButton() }()
    private lazy var nameView = { viewBuilder.makeViewForTextField() }()
    private lazy var nameLabel = { viewBuilder.makeTFLabel(with: "Full Name") }()
    private lazy var nameTextField = { viewBuilder.makeTextField(with: "Your name")}()
    private lazy var emailView = { viewBuilder.makeViewForTextField() }()
    private lazy var emailLabel = { viewBuilder.makeTFLabel(with: "Email") }()
    private lazy var emailTextField = { viewBuilder.makeTextField(with: "Your email")}()
    private lazy var saveButton = { viewBuilder.makeSaveButton() }()
    
    private var userNameLabel: UILabel = {
        UILabel.makeLabel(
            text: "User Name",
            font: UIFont.montserratSemiBold(ofSize: 16),
            textColor: .white,
            numberOfLines: 1
        )
    }()
    
    private var userEmailLabel: UILabel = {
        UILabel.makeLabel(
            text: "taraturin.kirill.dev@gmail.com",
            font: UIFont.montserratMedium(ofSize: 14),
            textColor: .customLightGrey,
            numberOfLines: 1
        )
    }()
    
    private var nameErrorLabel: UILabel = {
        var label = UILabel.makeLabel(
            text: "* Name already exist",
            font: UIFont.montserratMedium(ofSize: 12),
            textColor: .customRed,
            numberOfLines: 1
        )
        label.isHidden = true
        return label
    }()
    
    private var emailErrorLabel: UILabel = {
        var label = UILabel.makeLabel(
            text: "* Email already exist",
            font: UIFont.montserratMedium(ofSize: 12),
            textColor: .customRed,
            numberOfLines: 1
        )
        label.isHidden = true
        return label
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setViews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    
}

// MARK: - Setup Views
private extension EditProfileVC {
    func setupNavigationBar() {
        setNavigationBar(title: "Edit Profile")
    }
    
    func setViews() {
        view.backgroundColor = .customBlack
        view.addSubviewsTamicOff(userImageView,
                                 editButton,
                                 userNameLabel,
                                 userEmailLabel,
                                 nameView,
                                 nameLabel,
                                 emailView,
                                 emailLabel,
                                 nameErrorLabel,
                                 emailErrorLabel,
                                 saveButton
        )
        emailView.addSubview(emailTextField)
        nameView.addSubview(nameTextField)
    }
    
    
    func setupConstraints() {
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(75)
            make.height.equalTo(75)
        }
        
        editButton.snp.makeConstraints { make in
            make.bottom.equalTo(userImageView.snp.bottom).offset(1)
            make.right.equalTo(userImageView.snp.right).offset(5)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        userEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        nameView.snp.makeConstraints { make in
            make.top.equalTo(userEmailLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(55)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.top).offset(-7)
            make.left.equalTo(nameView.snp.left).offset(12)
            make.width.equalTo(80)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(55)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(55)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.top).offset(-7)
            make.left.equalTo(emailView.snp.left).offset(12)
            make.width.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        nameErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(10)
            make.left.equalTo(nameView.snp.left).offset(15)
        }
        
        emailErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(10)
            make.left.equalTo(emailView.snp.left).offset(15)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(60)
        }
    }
}

// MARK: - EditProfileVCProtocol
extension EditProfileVC: EditProfileVCProtocol {
    
}
