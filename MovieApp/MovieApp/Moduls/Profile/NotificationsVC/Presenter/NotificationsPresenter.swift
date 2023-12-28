//
//  NotificationsPresenter.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 28.12.2023.
//

import UIKit

// MARK: - NotificationsPresenterProtocol
protocol NotificationsPresenterProtocol {
    init(view: NotificationsVCProtocol)
    func showView()
}

// MARK: - NotificationsPresenter
final class NotificationsPresenter: NotificationsPresenterProtocol {
    
    private unowned var view: NotificationsVCProtocol
    
    init(view: NotificationsVCProtocol) {
        self.view = view
    }
    
    func showView() {
        view.showView()
    }
}
