//
//  EditProfileVC.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import UIKit
import PhotosUI

protocol EditProfileVCProtocol: AnyObject {
    func showUserData(_ user: User)
    func updateImageView(with image: UIImage)
    func updateUserNameLabel(with text: String)
    func updateUserEmailLabel(with text: String)
    func showImagePicker()
    
    func showNameError(_ message: String)
    func showEmailError(_ message: String)
    func hideNameError()
    func hideEmailError()
    func showSuccessMessage()
}

final class EditProfileVC: UIViewController {
    
    // MARK: - Presenter
    var presenter: EditProfilePresenterProtocol!
    
    // MARK: - ViewBuilder
    private let viewBuilder = ViewBuilder.shared
    
    // MARK: - UserInfo Views
    private lazy var userImageView = { viewBuilder.makeImageView() }()
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
    
    private lazy var editButton = {
        var button = viewBuilder.makeEditButton()
        button.addTarget(
            self,
            action: #selector(editButtonDidTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    // MARK: - UserName TextField
    private lazy var nameView = { viewBuilder.makeViewForTextField() }()
    private lazy var nameLabel = { viewBuilder.makeTFLabel(with: "Full Name") }()
    private lazy var nameTextField = {
        var textField = viewBuilder.makeTextField(with: "Your name")
        textField.addTarget(
            self,
            action: #selector(changeLabel),
            for: .editingChanged
        )
        return textField
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
    
    // MARK: - UserEmail TextField
    private lazy var emailView = { viewBuilder.makeViewForTextField() }()
    private lazy var emailLabel = { viewBuilder.makeTFLabel(with: "Email") }()
    private lazy var emailTextField = {
        var textField = viewBuilder.makeTextField(with: "Your email")
        textField.addTarget(
            self,
            action: #selector(changeLabel),
            for: .editingChanged
        )
        return textField
        
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
    
    // MARK: - SaveButton
    private lazy var saveButton = {
        var button = viewBuilder.makeSaveButton()
        button.addTarget(
            self,
            action: #selector(saveButtonDidTapped),
            for: .touchUpInside
        )
        return button
        
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setViews()
        setupConstraints()
        presenter.showUserData()
    }
    
    // MARK: - Private Actions
    @objc private func editButtonDidTapped() {
        presenter.didTapEditButton()
    }
    
    @objc private func changeLabel(_ sender: UITextField) {
        let textFieldType = sender == nameTextField
        ? TextFieldType.name
        : TextFieldType.email
        
        presenter.textFieldDidChange(text: sender.text ?? "", textFieldType: textFieldType)
    }
    
    @objc private func saveButtonDidTapped() {
        if let name = nameTextField.text,
        let email = emailTextField.text,
        let image = userImageView.image {
            presenter.validateAndSaveUserData(name: name, email: email, image: image)
        }
        
        //        let isNameEmpty = nameTextField.text?.isEmpty ?? true
        //        let isEmailEmpty = emailTextField.text?.isEmpty ?? true
        //
        //        if nameTextField.text == "" {
        //            valideTextField(textField: nameTextField, isError: false)
        //        } else {
        //            valideTextField(textField: nameTextField, isError: true)
        //        }
        //
        //        if emailTextField.text == "" {
        //            valideTextField(textField: emailTextField, isError: false)
        //        } else {
        //            valideTextField(textField: emailTextField, isError: true)
        //        }
        //
        //        guard let text = nameTextField.text, !text.isEmpty else { return }
        //
        //        if StorageManager.shared.isUserExist(withName: text) {
        //            nameErrorLabel.text = "* Name already exist"
        //            nameErrorLabel.isHidden = false
        //            nameView.layer.borderColor = UIColor.systemRed.cgColor
        //            return
        //        }
        //
        //        guard !isNameEmpty, !isEmailEmpty else {
        //            return
        //        }
        //
        //        if let name = nameTextField.text,
        //           let email = emailTextField.text,
        //           let image = userImageView.image {
        //
        //            presenter.saveUserData(name: name, email: email, image: image)
        //        }
        //
        //        NotificationCenter.default.post(
        //            name: NSNotification.Name("Saved"),
        //            object: nil
        //        )
    }
    
    // MARK: - Private Methods
    private func valideTextField(textField: UITextField, isError: Bool) {
        if textField == nameTextField {
            nameErrorLabel.isHidden = isError
            nameErrorLabel.text = "* Required field"
            nameView.layer.borderColor = isError
            ? UIColor.customGrey.cgColor
            :  UIColor.customRed.cgColor
            
        } else {
            emailErrorLabel.isHidden = isError
            emailErrorLabel.text = "* Required field"
            emailView.layer.borderColor = isError
            ? UIColor.customGrey.cgColor
            :  UIColor.customRed.cgColor
        }
    }
    
    private func showSuccessAlert() {
        let alert = UIAlertController(title: "", message: "Saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
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
    
    //validate methods
    func showNameError(_ message: String) {
        nameErrorLabel.text = message
        nameErrorLabel.isHidden = false
        nameView.layer.borderColor = UIColor.customRed.cgColor
    }
    
    func showEmailError(_ message: String) {
        emailErrorLabel.text = message
        emailErrorLabel.isHidden = false
        emailView.layer.borderColor = UIColor.customRed.cgColor
    }
    
    func hideNameError() {
        nameErrorLabel.isHidden = true
        nameView.layer.borderColor = UIColor.customGrey.cgColor
    }
    
    func hideEmailError() {
        emailErrorLabel.isHidden = true
        emailView.layer.borderColor = UIColor.customGrey.cgColor
    }
    
    func showSuccessMessage() {
        showSuccessAlert()
        NotificationCenter.default.post(
            name: NSNotification.Name("Saved"),
            object: nil
        )
    }
    
    // updateLabels from textField
    func updateUserNameLabel(with text: String) {
        userNameLabel.text = text
    }
    
    func updateUserEmailLabel(with text: String) {
        userEmailLabel.text = text
    }
    
    // show data from presenter
    func showUserData(_ user: User) {
        
        userNameLabel.text = user.fullName
        userEmailLabel.text = user.email
        userImageView.image = UIImage(data: user.image)
        
        nameTextField.text = user.fullName
        emailTextField.text = user.email
    }
    
    func updateImageView(with image: UIImage) {
        userImageView.image = image
    }
    
    func showImagePicker() {
        var configuration = PHPickerConfiguration()
        configuration.preferredAssetRepresentationMode = .automatic
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
}

// MARK: - PHPickerViewControllerDelegate
extension EditProfileVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        let firstItem = results.first?.itemProvider
        
        guard
            let itemProvider = firstItem, itemProvider.canLoadObject(ofClass: UIImage.self)
        else {
            return
        }
        
        itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            DispatchQueue.main.async {
                if let image = image as? UIImage {
                    self.presenter.didSelectImage(image)
                }
            }
        }
    }
}
