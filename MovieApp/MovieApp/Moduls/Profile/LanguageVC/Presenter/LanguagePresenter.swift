//
//  LanguagePresenter.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 28.12.2023.
//

import UIKit

// MARK: - LangugagePresenterProtocol
protocol LangugagePresenterProtocol {
    init(view: LanguageVCProtocol)
    var languages: [String] { get }
    var lastSelectedIndexPath: IndexPath? { get set }
}

// MARK: - LangugagePresenter
final class LangugagePresenter: LangugagePresenterProtocol {
    var lastSelectedIndexPath: IndexPath?
    
    
    private unowned var view: LanguageVCProtocol
    
    let languages = ["English", "Русский"]
    
    init(view: LanguageVCProtocol) {
        self.view = view
        self.lastSelectedIndexPath = IndexPath(row: 0, section: 0)
    }
}
