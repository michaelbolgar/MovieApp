//
//  NotificationsPresenter.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 28.12.2023.
//

import UIKit

// MARK: - NotificationsPresenterProtocol
protocol NotificationsPresenterProtocol {
    var hourPickerValue: Int { get set }
    var minutePickerValue: Int { get set }
    init(view: NotificationsVCProtocol)
    func showView()
    func showrequestAuthorization()
    func removeNotifications()
    func getDataFromPicker(hour: Int, minute: Int)
}

// MARK: - NotificationsPresenter
final class NotificationsPresenter: NotificationsPresenterProtocol {
    
    private unowned var view: NotificationsVCProtocol
    var hourPickerValue = 0
    var minutePickerValue = 0
    
    init(view: NotificationsVCProtocol) {
        self.view = view
    }
    
    func getDataFromPicker(hour: Int, minute: Int) {
        hourPickerValue = hour
        minutePickerValue = minute
    }
    
    func showView() {
        view.showView()
    }
    
    func showrequestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    self.scheduleNotification()
                }
            }
        }
    }
    
    func removeNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyReminder"])
    }
    
    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Напоминание"
        content.body = "Пора смотреть фильмы!"
        
        var dateComponents = DateComponents()
        
        dateComponents.hour = hourPickerValue
        dateComponents.minute = minutePickerValue
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        
        let request = UNNotificationRequest(
            identifier: "dailyReminder",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error)")
            }
        }
    }
}
