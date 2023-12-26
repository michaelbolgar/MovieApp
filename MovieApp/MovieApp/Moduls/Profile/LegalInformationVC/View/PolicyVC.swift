//
//  LegalInformationVC.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import UIKit


protocol PolicyVCProtocol: AnyObject {
    
}

final class PolicyVC: UIViewController {
    
    // MARK: - Presenter
    var presenter: PolicyPresenterProtocol!
    
    // MARK: - PolicyStorage
    private let policyText = PolicyStorage()
    
    // MARK: - Private UI Properties
    private let scrollView = UIScrollView()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupNavigationBar()
        setupSections()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func makeSection(with title: String, value: String, font: UIFont) -> UIStackView {
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
            numberOfLines: 0)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }
    
    private func setupSections() {
        let introductionSection = makeSection(
            with: "Introduction",
            value: policyText.getPolicyText(for: .introduction),
            font: .montserratMedium(ofSize: 14) ?? UIFont.systemFont(ofSize: 14)
        )
        
        let collectInfoSection = makeSection(
            with: "Information We Collect",
            value: policyText.getPolicyText(for: .collectInfo),
            font: .montserratMedium(ofSize: 14) ?? UIFont.systemFont(ofSize: 14)
        )
        
        let userInfoSection = makeSection(
            with: "How we User Your information",
            value: policyText.getPolicyText(for: .userInfo),
            font: .montserratMedium(ofSize: 14) ?? UIFont.systemFont(ofSize: 14)
        )
        
        let sharingSection = makeSection(
            with: "Sharing Your Information",
            value: policyText.getPolicyText(for: .sharingInfo),
            font: .montserratMedium(ofSize: 14) ?? UIFont.systemFont(ofSize: 14)
        )
        
        let contactUsSection = makeSection(
            with: "Contact Us",
            value: policyText.getPolicyText(for: .contactUS),
            font: .montserratMedium(ofSize: 14) ?? UIFont.systemFont(ofSize: 14)
        )
        
        let sections = [
            introductionSection,
            collectInfoSection,
            userInfoSection,
            sharingSection,
            contactUsSection
        ]
        
        let stackView = UIStackView(arrangedSubviews: sections)
        stackView.axis = .vertical
        stackView.spacing = 20
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(scrollView.snp.width).offset(-40)
        }
    }
}

// MARK: - Setup UI
extension PolicyVC {
    private func setViews() {
        view.backgroundColor = .customBlack
        view.addSubview(scrollView)
    }
    
    private func setupNavigationBar() {
        setNavigationBar(title: "Privacy Policy")
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = .customBlack
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - LegalInformationVCProtocol
extension PolicyVC: PolicyVCProtocol {
    
}
