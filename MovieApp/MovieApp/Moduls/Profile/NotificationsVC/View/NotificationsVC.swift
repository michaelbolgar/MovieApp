//
//  NotificationsVC.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 28.12.2023.
//

import UIKit

protocol NotificationsVCProtocol: AnyObject {
    func showView()
}

final class NotificationsVC: UIViewController {
    
    // MARK: - Presenter
    var presenter: NotificationsPresenterProtocol!
    
    // MARK: - Private UI Properties
    private var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.customGrey.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private var settingLabel: UILabel = {
        UILabel.makeLabel(
            text: "Messages Notifications",
            font: .montserratMedium(ofSize: 14),
            textColor: .customLightGrey,
            numberOfLines: 1
        )
    }()
    
    private var notificationsLabel: UILabel = {
        UILabel.makeLabel(
            text: "Show Notifications",
            font: .montserratMedium(ofSize: 18),
            textColor: .white,
            numberOfLines: 1
        )
    }()
    
    private var notificationSwitch: UISwitch = {
        var switcher = UISwitch()
        switcher.isOn = false
        switcher.onTintColor = .customBlue
        return switcher
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showView()
        setupNavigationBar()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setViews() {
        view.backgroundColor = .customBlack
        
        view.addSubview(mainView)
        
        [settingLabel, notificationsLabel, notificationSwitch].forEach { mainView.addSubview($0) }
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(LayoutConstraint.standardOffset)
            make.left.right.equalToSuperview()
                .inset(LayoutConstraint.standardOffset)
            make.height.equalTo(LayoutConstraint.mainViewHeight)
        }
        
        settingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(LayoutConstraint.settingLabelTopOffset)
            make.left.equalToSuperview()
                .offset(LayoutConstraint.labelLeftOffset)
        }
        
        notificationsLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
                .offset(LayoutConstraint.notificationsLabelBottomOffset)
            make.left.equalToSuperview()
                .offset(LayoutConstraint.labelLeftOffset)
        }
        
        notificationSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(notificationsLabel.snp.centerY)
            make.right.equalToSuperview()
                .offset(-LayoutConstraint.standardOffset)
        }
    }
    
    private func setupNavigationBar() {
        setNavigationBar(title: "Notification")
    }
}

// MARK: - NotificationsVCProtocol
extension NotificationsVC: NotificationsVCProtocol {
    func showView() {
        setViews()
    }
}

// MARK: - NotificationsLayout
enum LayoutConstraint {
    static let standardOffset: CGFloat = 20
    static let mainViewHeight: CGFloat = 130

    static let settingLabelTopOffset: CGFloat = 28
    static let labelLeftOffset: CGFloat = 16

    static let notificationsLabelBottomOffset: CGFloat = -28
}

