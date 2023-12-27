//
//  MainTabBarController .swift
//  MovieApp
//
//  Created by Мой Macbook on 27.12.2023.
//


import UIKit

final class MainTabBarController: UITabBarController, TabBarViewProtocol {

    private lazy var tabBarPresenter = TabBarPresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .customBlack
        tabBar.tintColor = .customBlue
        tabBar.unselectedItemTintColor = .customLightGrey
        tabBarPresenter.generateVC()
    }
    
    // Реализация метода протокола
    func setupTabBar(with viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }
}
