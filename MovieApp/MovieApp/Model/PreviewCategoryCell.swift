import UIKit
import SnapKit

class previewCategoryCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = String(describing: previewCategoryCell.self)
    
    private let filmeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameCategoryLabel:UILabel = .makeLabel(font: UIFont.montserratSemiBold(ofSize: 16), textColor: .white, numberOfLines: 1)
    private let namberOfMoviesLabel:UILabel = .makeLabel(font: UIFont.montserratRegular(ofSize: 12), textColor: .white, numberOfLines: 1)
    
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
        contentView.addSubview(namberOfMoviesLabel)
    }
    
    func configure(with model: MovieCellModel) {
        filmeImage.image = model.image
        nameCategoryLabel.text = model.name
        namberOfMoviesLabel.text = model.numberOfMovies + " movies"
    }
    
    private func setupConstraints() {
        
        filmeImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        nameCategoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(filmeImage.snp.leading).offset(16)
            make.trailing.equalTo(filmeImage.snp.trailing).inset(16)
            make.centerY.equalTo(filmeImage.snp.centerY)
        }
        
        namberOfMoviesLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameCategoryLabel.snp.leading).offset(16)
            make.bottom.equalTo(filmeImage.snp.bottom).inset(16)
        }
        
    }
    
}

struct MovieCellModel {
    let image: UIImage
    let name: String
    let numberOfMovies: String
}

struct Source{
    static func getMovies() ->[MovieCellModel]{
        return [
            MovieCellModel(image: UIImage(named: "background12")!, name: "100 great movies", numberOfMovies: "2000"),
//            MovieCellModel(image: UIImage(named: "background12")!, name: "50 great movies", numberOfMovies: "2000"),
        ]
    }
}
