//
//  MainTabBarController .swift
//  MovieApp
//
//  Created by Мой Macbook on 27.12.2023.
//


import UIKit

class MainTabBarController: UITabBarController, TabBarViewProtocol {
    
    private var presenter: TabBarPresenterProtocol!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .customBlue
        tabBar.unselectedItemTintColor = .customLightGrey
        setupTabBar()
        presenter = TabBarPresenter(view: self, tabFactory: TabBarFactory())
        presenter.generateVC()
    }
    
    // MARK: - Private Methods
    private func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor.customBlack
        
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
    
    //MARK: - Protocol methods
    func setupTabs(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }
}
