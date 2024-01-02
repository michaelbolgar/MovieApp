//
//  TabBarPresenter .swift
//  MovieApp
//
//  Created by Мой Macbook on 27.12.2023.
//

import UIKit

protocol TabBarViewProtocol: AnyObject {
    func setupTabs(_ viewControllers: [UIViewController])
}

protocol TabBarPresenterProtocol {
    func generateVC()
}

class TabBarPresenter: TabBarPresenterProtocol {
   
    //MARK: - Properties
    weak var view: TabBarViewProtocol?
    let tabFactory: TabBarFactoryProtocol
    
    //MARK: - Init
    init(view: TabBarViewProtocol, tabFactory: TabBarFactoryProtocol) {
        self.view = view
        self.tabFactory = tabFactory
    }
    
    //MARK: - Protocol methods
    func generateVC() {
        let tabs = tabFactory.createTabs()
        view?.setupTabs(tabs)
    }
}
