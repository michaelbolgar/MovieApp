//
//  TableCell.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import UIKit
import SnapKit

final class TableCell<View>: UITableViewCell where View: UIView & Configurable {
    private let view = View()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
    func update(with model: View.Model, height: CGFloat? = nil) {
        view.update(model: model)
        
        if let height {
            view.snp.makeConstraints {
                $0.height.equalTo(height)
            }
        }
    }
}
