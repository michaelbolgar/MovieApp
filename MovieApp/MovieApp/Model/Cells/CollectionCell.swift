//
//  CollectionCell.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 04.01.24.
//

import UIKit
import SnapKit

final class CollectionCell<View>: UICollectionViewCell where View: UIView & Configurable {
    private let view = View()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configure()
    }

    private func configure() {
        contentView.addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func update(with model: View.Model) {
        view.update(model: model)
    }
}
