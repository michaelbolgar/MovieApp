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
    func showPolicyInfo()
}

// MARK: - LegalPresenter
final class PolicyPresenter: PolicyPresenterProtocol {

    
    
    private unowned var view: PolicyVCProtocol
    private let policyStorage = PolicyStorage()
    
    init(view: PolicyVCProtocol) {
        self.view = view
    }
    
    func showPolicyInfo() {
        let policy = Policy(
            introduction: policyStorage.getPolicyText(for: .introduction),
            collectInfo: policyStorage.getPolicyText(for: .collectInfo),
            userInfo: policyStorage.getPolicyText(for: .userInfo),
            sharingInfo: policyStorage.getPolicyText(for: .sharingInfo),
            dataSecurity: policyStorage.getPolicyText(for: .dataSecurity),
            changePolicy: policyStorage.getPolicyText(for: .changePolicy),
            contactUS: policyStorage.getPolicyText(for: .contactUS)
        )
        view.setPolicy(with: policy)
    }
}
