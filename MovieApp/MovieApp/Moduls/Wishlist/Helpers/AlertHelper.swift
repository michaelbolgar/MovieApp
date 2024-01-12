//
//  AlertController.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 31.12.2023.
//

import UIKit

final class AlertHelper {
    static func createDeleteAlert(completion: @escaping (Bool) -> Void) -> UIAlertController {
        let alert = UIAlertController(
            title: "",
            message: "Are you sure you want to delete all the movies?",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            completion(true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
        }
        
        [okAction, cancelAction].forEach { alert.addAction($0) }
        return alert
    }
}

