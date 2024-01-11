//
//  ShareView.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 11.01.24.
//

import UIKit

// Класс для представления всплывающего окна с кнопками поделиться
class ShareView: UIView {
    
    private lazy var facebookButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(
            UIImage(
                named: Images.faceBook
            )?.withRenderingMode(
                .alwaysOriginal
            ), for: .normal
        )
        btn.contentMode = .scaleAspectFit // Измените здесь
           btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    private lazy var instagramButton: UIButton = {
        let btn = UIButton(
            type: .system
        )
        btn.setImage(
            UIImage(
                named: Images.inst
            )?.withRenderingMode(
                .alwaysOriginal
            ), for: .normal
        )
        btn.contentMode = .scaleAspectFit // Измените здесь
           btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    private lazy var twitterButton: UIButton = {
        let btn = UIButton(
            type: .system
        )
        btn.setImage(
            UIImage(
                named: Images.twitter
            )?.withRenderingMode(
                .alwaysOriginal
            ), for: .normal
        )
        btn.contentMode = .scaleAspectFit // Измените здесь
           btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    private lazy var fbMessanger: UIButton = {
        let btn = UIButton(
            type: .system
        )
        btn.setImage(
            UIImage(
                named: Images.twitter
            )?.withRenderingMode(
                .alwaysOriginal
            ), for: .normal
        )
        btn.contentMode = .scaleAspectFit
           btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    let closeButton: UIButton = {
        let btn = UIButton(
            type: .system
        )
        btn.setImage(
            UIImage(
                named: Images.close
            )?.withRenderingMode(
                .alwaysOriginal
            ), for: .normal
        )
        btn.contentMode = .scaleAspectFill
        return btn
    }()
    
    let shareLabel = UILabel.makeLabel(text: "Share to", font: .montserratSemiBold(ofSize: 18), textColor: .white, numberOfLines: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        // Настройка внешнего вида и добавление кнопок на ShareView
        self.backgroundColor = .gray
        self.layer.cornerRadius = 16
        
        // Добавление кнопок на view
        let stackView = UIStackView(arrangedSubviews: [facebookButton, instagramButton, twitterButton, fbMessanger])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        self.addSubview(stackView)
        self.addSubview(closeButton)
        self.addSubview(shareLabel)
        
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.height.equalTo(32)
        }
        
        shareLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(closeButton.snp.bottom).offset(15)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(shareLabel.snp.bottom).offset(30)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(49)
            $0.width.equalToSuperview().inset(30)
        }
    }
}

private enum Images {
    static let faceBook = "Fb"
    static let twitter = "Twitter"
    static let faceBookMessanger = "Fb Messanger"
    static let inst = "Inst"
    static let close = "Close"
}
