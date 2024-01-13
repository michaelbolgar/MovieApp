import UIKit
import SnapKit

final class DetailStoryLineCell: UICollectionViewCell {
    
    static let identifier = String(describing: DetailStoryLineCell.self)
    
    var onMoreButtonTapped: (() -> Void)?
    
    // UILabel для текста сюжета
    let storyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textColor = .white
        return label
    }()

    // UIButton для кнопки "More"
    let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("More", for: .normal)
        button.titleLabel?.textColor = .customBlue
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        moreButton.addTarget(self, action: #selector(toggleText), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func toggleText() {
        onMoreButtonTapped?() // Вызов замыкания при нажатии
    }
    
    private func setupViews() {
        contentView.addSubview(storyLabel)
        contentView.addSubview(moreButton)
        
        // Настройка констрейнтов с использованием SnapKit
        storyLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(storyLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configure(with text: String, isExpanded: Bool) {
        storyLabel.text = text
        storyLabel.numberOfLines = isExpanded ? 0 : 5
        moreButton.setTitle(isExpanded ? "Less" : "More", for: .normal)
    }
}
