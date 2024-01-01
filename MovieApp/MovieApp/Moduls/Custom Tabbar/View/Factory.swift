//
//  Factory.swift
//  MovieApp
//
//  Created by Мой Macbook on 28.12.2023.
//

import UIKit

protocol TabBarFactoryProtocol {
    func createTabs() -> [UIViewController]
}

class TabBarFactory: TabBarFactoryProtocol {
//class TabBarFactory {

    //MARK: - Methods
    func createTabs() -> [UIViewController] {
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", 
                                         image: UIImage(systemName: "house.fill"),
                                         tag: 0)
        homeVC.view.backgroundColor = .customBlack
        
        let searchVC = SearchVC()
        searchVC.tabBarItem = UITabBarItem(title: "Search", 
                                           image: UIImage(systemName: "magnifyingglass"),
                                           tag: 1)
        searchVC.view.backgroundColor = .customBlack
        
        let treeVC = ChristmasTreeVC()
        treeVC.tabBarItem = UITabBarItem(title: "Tree", 
                                         image: UIImage(systemName: "puzzlepiece.extension.fill"),
                                         tag: 2)
        treeVC.view.backgroundColor = .customBlack
        
        let navigationController = UINavigationController()
        let moduleBuilder = ModuleBuilder()
        let router = ProfileRouter(
            navigationController: navigationController,
            moduleBuilder: moduleBuilder
        )
        router.initialViewController()
        
        let profileVC = navigationController
        profileVC.tabBarItem = UITabBarItem(title: "Profile", 
                                            image: UIImage(systemName: "person.fill"),
                                            tag: 3)
        profileVC.view.backgroundColor = .customBlack
        
        return [homeVC, searchVC, treeVC, profileVC]
    }
}

//private extension TabBarFactory {
//
//    func setupTabBar() {
//        let tabBarAppearance = UITabBarAppearance()
//        tabBarAppearance.backgroundColor = UIColor.customBlack
//
//        tabBar.tintColor = .customBlue
//        tabBar.unselectedItemTintColor = .customLightGrey
//        tabBar.standardAppearance = tabBarAppearance
//        tabBar.scrollEdgeAppearance = tabBarAppearance
//    }
//}
