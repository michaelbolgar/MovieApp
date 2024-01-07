import UIKit
import SnapKit

class PreviewCategoryCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = String(describing: PreviewCategoryCell.self)
    
    private let filmeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameCategoryLabel:UILabel = .makeLabel(font: UIFont.montserratSemiBold(ofSize: 16), textColor: .white, numberOfLines: 1)
    private let descriptionLabel:UILabel = .makeLabel(font: UIFont.montserratRegular(ofSize: 12), textColor: .white, numberOfLines: 1)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .customGrey
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupViews() {
        contentView.addSubview(filmeImage)
        contentView.addSubview(nameCategoryLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    //FIXME: - Переделать когда будет готова сеть
    func configure(with model: MovieCellModel) {
        filmeImage.image = model.image
        nameCategoryLabel.text = model.name
        descriptionLabel.text = model.description
    }
    
    private func setupConstraints() {
        
        filmeImage.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        nameCategoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(filmeImage.snp.leading).offset(16)
            make.trailing.equalTo(filmeImage.snp.trailing).inset(16)
            make.centerY.equalTo(filmeImage.snp.centerY)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameCategoryLabel.snp.leading)
            make.bottom.equalTo(filmeImage.snp.bottom).inset(16)
        }
        
    }
    
}

//FIXME: 
struct MovieCellModel {
    let image: UIImage?
    let name: String
    let description: String
}
