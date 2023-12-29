//
//  EditProfileVC + Extension.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 29.12.2023.
//

import Foundation
import PhotosUI

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
    
    func setupImagePicker() {
        var configuration = PHPickerConfiguration()
        configuration.preferredAssetRepresentationMode = .automatic
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
}
