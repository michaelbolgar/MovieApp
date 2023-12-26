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
}

// MARK: - EditProfilePresenter
final class EditProfilePresenter: EditProfilePresenterProtocol {
    
    private unowned var view: EditProfileVCProtocol
    
    init(view: EditProfileVCProtocol) {
        self.view = view
    }
}


