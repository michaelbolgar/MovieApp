//
//  ProfileRouter.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import UIKit

// MARK: - RouterMain
protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
}

// MARK: - ProfileRouterProtocol
protocol ProfileRouterProtocol: RouterMain {
    func initialViewCOntroller()
}

// MARK: - ProfileRouter
final class ProfileRouter: ProfileRouterProtocol {
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    func initialViewCOntroller() {
        if let navigationController = navigationController {
            guard let profileVC = moduleBuilder?.createProfileModule(router: self) else { return }
            navigationController.viewControllers = [profileVC]
        }
    }
}
