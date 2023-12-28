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
    weak var view: TabBarViewProtocol?
    let tabFactory: TabBarFactoryProtocol
    
    init(view: TabBarViewProtocol, tabFactory: TabBarFactoryProtocol) {
        self.view = view
        self.tabFactory = tabFactory
    }
    
    func generateVC() {
        let tabs = tabFactory.createTabs()
        view?.setupTabs(tabs)
    }
}
