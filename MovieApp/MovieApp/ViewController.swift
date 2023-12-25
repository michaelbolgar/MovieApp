//
//  ViewController.swift
//  MovieApp
//
//  Created by Михаил Болгар on 24.12.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let label = UILabel.makeLabel(text: "Hello, world!", font: UIFont.montserratSemiBold(ofSize: 20), textColor: .customBlack, numberOfLines: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBlue

        view.addSubview(label)

        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
