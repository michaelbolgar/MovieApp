//
//  LegalInformationVC.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import UIKit


protocol PolicyVCProtocol: AnyObject {
    func setPolicy(with policy: Policy)
}

final class PolicyVC: UIViewController {
    
    // MARK: - Presenter
    var presenter: PolicyPresenterProtocol!
    
    // MARK: - Private UI Properties
    private let scrollView = UIScrollView()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupNavigationBar()
        setupConstraints()
        presenter.showPolicyInfo()
    }
    
    // MARK: - Private Methods
    private func makeSection(with title: String, value: String) -> UIStackView {
        let titleLabel = UILabel.makeLabel(
            text: title,
            font: .montserratSemiBold(ofSize: 14),
            textColor: .white,
            numberOfLines: 1
        )
        
        let valueLabel = UILabel.makeLabel(
            text: value,
            font: .montserratMedium(ofSize: 14),
            textColor: .customLightGrey,
            numberOfLines: 0
        )
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }
    
    private func setupSections(with policy: Policy) {
        
        let titles = [
            ("Introduction", policy.introduction),
            ("Information We Collect", policy.collectInfo),
            ("How we User Your information", policy.userInfo),
            ("Sharing Your Information", policy.sharingInfo),
            ("Contact Us", policy.contactUS)
        ]
        
        let sectionsAll = titles.map { (key, value) in
            makeSection(
                with: key,
                value: value
            )
        }
        
        let stackView = UIStackView(arrangedSubviews: sectionsAll)
        stackView.axis = .vertical
        stackView.spacing = 20
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.width.equalTo(scrollView.snp.width).offset(-40)
        }
    }
}

// MARK: - LegalInformationVCProtocol
extension PolicyVC: PolicyVCProtocol {
    func setPolicy(with policy: Policy) {
        setupSections(with: policy)
    }
}

// MARK: - Setup UI
private extension PolicyVC {
    func setViews() {
        view.backgroundColor = .customBlack
        view.addSubview(scrollView)
    }
    
    func setupNavigationBar() {
        setNavigationBar(title: "Privacy Policy")
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = .customBlack
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.top.bottom.equalToSuperview()
        }
    }
}



