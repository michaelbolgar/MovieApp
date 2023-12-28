//
//  MainTabBarController .swift
//  MovieApp
//
//  Created by Мой Macbook on 27.12.2023.
//


import UIKit

class MainTabBarController: UITabBarController, TabBarViewProtocol {
    
    private var presenter: TabBarPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .customBlue
        tabBar.unselectedItemTintColor = .customLightGrey
        
        presenter = TabBarPresenter(view: self, tabFactory: TabBarFactory())
        presenter.generateVC()
    }
    
    func setupTabs(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }
}
