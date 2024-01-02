//
//  AboutUsPresenter.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import UIKit

// MARK: - AboutUsPresenterProtocol
protocol AboutUsPresenterProtocol {
    init(view: AboutUsVCProtocol)
    var developers: [Developer] { get }
    func showDevelopers()
}

// MARK: - AboutUsPresenter
final class AboutUsPresenter: AboutUsPresenterProtocol {
    
    private unowned var view: AboutUsVCProtocol
    var developers: [Developer]
    
    init(view: AboutUsVCProtocol) {
        self.view = view
        self.developers = Developer.getTeam()
    }
    
    func showDevelopers() {
        view.reloadData()
    }
}

