//
//  PolicyStorage.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import Foundation

enum PolicyType {
    case introduction
    case collectInfo
    case userInfo
    case sharingInfo
    case dataSecurity
    case changePolicy
    case contactUS
}

final class PolicyStorage {
    
    // MARK: - Private Properties
    private let introduction =
     """
     Welcome to MovieApp. Your privacy is important to us. This Privacy Policy explains how we collect, use, protect, and share information and data when you use [Your App Name]. This policy applies to all users of our app and services.
     """
    private let collectInformation =
    """
    We collect information to provide better services to all of our users. The types of information we collect include:

    Personal Information: This is information that you provide to us which personally identifies you, such as your name, email address, and billing information.
    Usage Information: We collect information about your interactions with our app, such as the pages you visit, the content you view, and the dates and times of your visits.
    Device Information: We may collect specific information about your device when you access our app, including model, operating system, unique device identifiers, and mobile network information.
"""
    
    private let useInformation =
    """
We use the information we collect to:

Provide, maintain, and improve our services;
Develop new services;
Protect [Your App Name] and our users;
Communicate with you about our services, including service updates and responses to your inquiries.
"""
    
    private let sharingInformation =
    """
We do not share your personal information with companies, organizations, or individuals outside of [Your App Name] except in the following cases:

With your consent;
For external processing by our trusted service providers based on our instructions and in compliance with our Privacy Policy;
For legal reasons, including to meet any applicable law, regulation, legal process or enforceable governmental request.
"""
    
    private let dataSecurity =
    """

We are committed to protecting the data of our users. We implement a variety of security measures to maintain the safety of your personal information.
"""
    
    private let changePolicy =
    """

Our Privacy Policy may change from time to time. We will post any privacy policy changes on this page and, if the changes are significant, we will provide a more prominent notice.
"""
    
    private let contactUs =
    """
If you have questions or concerns about MovieApp Privacy Policy, please contact us at movieapp@gmail.com.
"""
    
    // MARK: - Public Methods
    func getPolicyText(for type: PolicyType) -> String {
        switch type {
        case .introduction:
            return introduction
        case .collectInfo:
            return collectInformation
        case .userInfo:
            return useInformation
        case .sharingInfo:
            return sharingInformation
        case .dataSecurity:
            return dataSecurity
        case .changePolicy:
            return changePolicy
        case .contactUS:
            return contactUs
        }
    }
}
