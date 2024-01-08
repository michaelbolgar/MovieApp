//
//  HomeBuilder.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 08.01.2024.
//

import UIKit

// MARK: - ModuleBuilderProtocol
protocol HomeBuilderProtocol {
    func createHomeModule(router: HomeRouterProtocol) -> UIViewController
}

// MARK: - ModuleBUilder
final class HomeBuilder: HomeBuilderProtocol {

    func createHomeModule(router: HomeRouterProtocol) -> UIViewController {
        let view = HomeViewController()
        let storageManager = StorageManager.shared
        let presenter = HomePresenter(view: view, storageManager: storageManager)
        view.presenter = presenter
        return view
    }
}

