//
//  MoreView.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 25.12.2023.
//

import UIKit

final class MoreView: BaseSettingView {
    
    // MARK: - Init
    init() {
        super.init(
            frame: .zero,
            title: "More",
            firstSettingTitle: "Legal and Policies",
            secondSettingTitle: "About Us"
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
