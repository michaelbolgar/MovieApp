//
//  ModuleBuilder.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import UIKit

// MARK: - ModuleBuilderProtocol
protocol ModuleBuilderProtocol {
    func createProfileModule(router: ProfileRouterProtocol) -> UIViewController
    func createEditProfileVC() -> UIViewController
    func createPoliciesVC() -> UIViewController
}

// MARK: - ModuleBUilder
final class ModuleBUilder: ModuleBuilderProtocol {

    func createProfileModule(router: ProfileRouterProtocol) -> UIViewController {
        let view = ProfileVC()
        let presenter = ProfilePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createEditProfileVC() -> UIViewController {
        let view = EditProfileVC()
        let presenter = EditProfilePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createPoliciesVC() -> UIViewController {
        let view = PolicyVC()
        let presenter = PolicyPresenter(view: view)
        view.presenter = presenter
        return view
    }
}

