//
//  NotificationsVC.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 28.12.2023.
//

import UIKit
import SnapKit

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
    
    private var settingLabel = UILabel.makeLabel(
        text: "Messages Notifications",
        font: .montserratMedium(ofSize: 14),
        textColor: .customLightGrey,
        numberOfLines: 1
    )
    
    private var notificationsLabel = UILabel.makeLabel(
        text: "Show Notifications",
        font: .montserratMedium(ofSize: 16),
        textColor: .white,
        numberOfLines: 1
    )
    
    private var notificationSwitch: UISwitch = {
        var switcher = UISwitch()
        switcher.isOn = false
        switcher.onTintColor = .customBlue
        switcher.addTarget(
            self,
            action: #selector(switcherDidChanged),
            for: .valueChanged
        )
        return switcher
    }()
    
    private let timeLabel = UILabel.makeLabel(
        text: "Send notifications at",
        font: UIFont.montserratMedium(ofSize: 16),
        textColor: .white,
        numberOfLines: 1
    )
    
    private let timePicker: UIDatePicker = {
        var picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.backgroundColor = .customBlack
        picker.tintColor = .white
        picker.layer.borderWidth = 1
        picker.layer.borderColor = UIColor.white.cgColor
        picker.layer.cornerRadius = 10
        picker.clipsToBounds = true
        picker.overrideUserInterfaceStyle = .dark
        picker.locale = Locale(identifier: "en_GB")
        picker.addTarget(
            self,
            action: #selector(pickerTimeDidChanged),
            for: .valueChanged
        )
        return picker
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: "Notification")
        presenter.showView()
        setupConstraints()
        updateDataFromPickerToPresenter()
    }
    
    // MARK: - Private Actions
    @objc private func pickerTimeDidChanged() {
        updateDataFromPickerToPresenter()
    }
    
    @objc private func switcherDidChanged() {
        let value = notificationSwitch.isOn
        
        if value {
            presenter.showrequestAuthorization()
        } else {
            presenter.removeNotifications()
        }
    }
    
    // MARK: - Picker Methods
    private func getHourFromPicker() -> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self.timePicker.date)
        return hour
    }
    
    private func getMinutesFromPicker() -> Int {
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: self.timePicker.date)
        return minute
    }
    
    private func updateDataFromPickerToPresenter() {
        let hour = getHourFromPicker()
        let minute = getMinutesFromPicker()
        presenter.getDataFromPicker(hour: hour, minute: minute)
    }
}

// MARK: - NotificationsVCProtocol
extension NotificationsVC: NotificationsVCProtocol {
    func showView() {
        setViews()
    }
}

// MARK: - Setup UI
private extension NotificationsVC {
    
    func setViews() {
        view.backgroundColor = .customBlack
        view.addSubview(mainView)
        [settingLabel, notificationsLabel, notificationSwitch, timePicker, timeLabel].forEach { mainView.addSubview($0)
        }
    }
    
    func setupConstraints() {
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
            make.top.equalTo(settingLabel.snp.bottom)
                .offset(40)
            make.left.equalToSuperview()
                .offset(LayoutConstraint.labelLeftOffset)
        }
        
        notificationSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(notificationsLabel.snp.centerY)
            make.right.equalToSuperview()
                .offset(-LayoutConstraint.standardOffset)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(notificationsLabel.snp.bottom).offset(20)
        }
        
        timePicker.snp.makeConstraints { make in
            make.top.equalTo(notificationSwitch.snp.bottom).offset(25)
            make.centerY.equalTo(timeLabel.snp.centerY)
            make.centerX.equalTo(notificationSwitch.snp.centerX)
        }
    }
    
    enum LayoutConstraint {
        static let standardOffset: CGFloat = 30
        static let mainViewHeight: CGFloat = 200
        static let settingLabelTopOffset: CGFloat = 28
        static let labelLeftOffset: CGFloat = 16
        static let notificationsLabelBottomOffset: CGFloat = -28
    }
}



