//
//  ProfileRouter.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import UIKit

// MARK: - RouterMain
protocol RouterProtocol {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
}

// MARK: - ProfileRouterProtocol
protocol ProfileRouterProtocol: RouterProtocol {
    func initialViewController()
    func showEditProfileVC()
    func showPolicyVC()
    func showAboutUsVC()
    func showNotificationVC()
    func showLanguageVC()
}

// MARK: - ProfileRouter
final class ProfileRouter: ProfileRouterProtocol {
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let profileVC = moduleBuilder?.createProfileModule(router: self) else { return }
            navigationController.viewControllers = [profileVC]
        }
    }
    
    func showEditProfileVC() {
        if let navigationController = navigationController {
            guard let editProfileVC = moduleBuilder?.createEditProfileVC() else { return }
            navigationController.pushViewController(editProfileVC, animated: true)
        }
    }
    
    func showPolicyVC() {
        if let navigationController = navigationController {
            guard let policiesVC = moduleBuilder?.createPoliciesVC() else { return }
            navigationController.pushViewController(policiesVC, animated: true)
        }
    }
    
    func showAboutUsVC() {
        if let navigationController = navigationController {
            guard let aboutUsVC = moduleBuilder?.createAboutUsVC() else { return }
            navigationController.pushViewController(aboutUsVC, animated: true)
        }
    }
    
    func showNotificationVC() {
        if let navigationController = navigationController {
            guard let notificationVC = moduleBuilder?.createNotificationVC() else { return }
            navigationController.pushViewController(notificationVC, animated: true)
        }
    }
    
    func showLanguageVC() {
        if let navigationController = navigationController {
            guard let languageVC = moduleBuilder?.createLanguageVC() else { return }
            navigationController.pushViewController(languageVC, animated: true)
        }
    }
}
