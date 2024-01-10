//
//  MainTabBarController .swift
//  MovieApp
//
//  Created by Мой Macbook on 27.12.2023.
//


import UIKit

class MainTabBarController: UITabBarController {

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    // MARK: - Private Methods
    private func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor.customBlack
        tabBar.tintColor = .customBlue
        tabBar.unselectedItemTintColor = .customLightGrey
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}
