//
//  Presenter.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import UIKit

enum TextFieldType {
    case name
    case email
}

// MARK: - EditProfilePresenterProtocol
protocol EditProfilePresenterProtocol {
    init(view: EditProfileVCProtocol)
    func showUserData()
    func didSelectImage(_ image: UIImage)
    func didTapEditButton()
    func saveUserData(name: String, email: String, image: UIImage)
    func textFieldDidChange(text: String, textFieldType: TextFieldType)
    func validateAndSaveUserData(name: String, email: String, image: UIImage)
}

// MARK: - EditProfilePresenter
final class EditProfilePresenter: EditProfilePresenterProtocol {
    
    private unowned var view: EditProfileVCProtocol
    private let storageManager = StorageManager.shared
    
    init(view: EditProfileVCProtocol) {
        self.view = view
    }
    
    func showUserData() {
        if let user = storageManager.fetchUser() {
            view.showUserData(user)
        }
    }
    
    func didSelectImage(_ image: UIImage) {
        view.updateImageView(with: image)
    }
    
    func didTapEditButton() {
        view.showImagePicker()
    }
    
    func saveUserData(name: String, email: String, image: UIImage) {
        let user = User()
        
        user.fullName = name
        user.email = email
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            user.image = imageData
        }
        storageManager.save(user)
    }
    
    func textFieldDidChange(text: String, textFieldType: TextFieldType) {
        switch textFieldType {
        case .name:
            view.updateUserNameLabel(with: text)
        case .email:
            view.updateUserEmailLabel(with: text)
        }
    }
    
    func validateAndSaveUserData(name: String, email: String, image: UIImage) {
        var isValid = true
        
        if name.isEmpty {
            view.showNameError("* Required field")
            isValid = false
        } else {
            view.hideNameError()
        }
        
        if email.isEmpty {
            view.showEmailError("* Required field")
            isValid = false
        } else {
            if !isValidEmail(email) {
                view.showEmailError("* Please, enter a valid email address")
                isValid = false
            } else {
                view.hideEmailError()
            }
        }
        
        if !name.isEmpty {
            if storageManager.isUserExist(withName: name) {
                view.showNameError("* Name already exist")
                isValid = false
            }
        }
        
        if isValid {
            saveUserData(name: name, email: email, image: image)
            view.showSuccessMessage()
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}


