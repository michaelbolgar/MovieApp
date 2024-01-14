//
//  CustomBarItem.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 14.01.24.
//

import UIKit

final class CustomBarItem {
    
    static let shared = CustomBarItem()
    
    func createCustomButton(target: Any, action: Selector) -> UIBarButtonItem {
        let view = UIView()
        view.backgroundColor = .customGrey
        view.layer.cornerRadius = 11
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.tintColor = .customRed
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(
            target,
            action: action,
            for: .touchUpInside
        )
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview().offset(-3)
            make.leading.equalToSuperview().offset(3)
            make.trailing.equalToSuperview().offset(-3)
        }
        
        let menuBarItem = UIBarButtonItem(customView: view)
        return menuBarItem
    }
}
