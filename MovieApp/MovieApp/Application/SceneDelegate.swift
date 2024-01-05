//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by Михаил Болгар on 24.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        
        func makeScreen() -> UIViewController {
            let controller = DetailViewController()
            let presenter = DetailPresenter()
            
            controller.presenter = presenter
            presenter.view = controller
            
            return controller
        }

        window.rootViewController = makeScreen()
//        let navigationController = UINavigationController()
//        let moduleBuilder = ModuleBuilder()
//        let router = ProfileRouter(
//            navigationController: navigationController,
//            moduleBuilder: moduleBuilder
//        )
//        router.initialViewController()
//        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}
