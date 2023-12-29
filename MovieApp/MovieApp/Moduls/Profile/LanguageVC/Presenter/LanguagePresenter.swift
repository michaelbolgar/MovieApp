//
//  LanguagePresenter.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 28.12.2023.
//

import UIKit

// MARK: - LangugagePresenterProtocol
protocol LanguagePresenterProtocol {
    init(view: LanguageVCProtocol)
    var languages: [String] { get }
    var lastSelectedIndexPath: IndexPath? { get set }
}

// MARK: - LangugagePresenter
final class LanguagePresenter: LanguagePresenterProtocol {

    private unowned var view: LanguageVCProtocol
    
    let languages = ["English", "Русский"]
    var lastSelectedIndexPath: IndexPath?
    
    init(view: LanguageVCProtocol) {
        self.view = view
        self.lastSelectedIndexPath = IndexPath(row: 0, section: 0)
    }
}
