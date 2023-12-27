//
//  Presenter.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import UIKit

// MARK: - EditProfilePresenterProtocol
protocol EditProfilePresenterProtocol {
    init(view: EditProfileVCProtocol)
    func showUserData()
    func didSelectImage(_ image: UIImage)
    func didTapEditButton()
    func saveUserData(name: String, email: String, image: UIImage)
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
}


