//
//  GeneralView.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 25.12.2023.
//

import UIKit

final class GeneralView: BaseSettingView {
    
    // MARK: - Init
    init() {
        super.init(
            frame: .zero,
            title: "General",
            firstSettingTitle: "Notification",
            
            secondSettingTitle: "Language")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
