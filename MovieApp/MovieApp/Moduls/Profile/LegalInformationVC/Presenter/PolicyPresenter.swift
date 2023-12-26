//
//  LegalInformationPresenter.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import UIKit

// MARK: - LegalPresenterProtocol
protocol PolicyPresenterProtocol {
    init(view: PolicyVCProtocol)
}

// MARK: - LegalPresenter
final class PolicyPresenter: PolicyPresenterProtocol {
    
    private unowned var view: PolicyVCProtocol
    
    init(view: PolicyVCProtocol) {
        self.view = view
    }
}
