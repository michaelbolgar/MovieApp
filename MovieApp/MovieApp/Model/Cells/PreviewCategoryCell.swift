import UIKit

#warning("переименовать после того как разберемся с MovieListCell")
final class PreviewCategoryCell: UICollectionViewCell {
    
    //MARK: - Static Properties
    static let identifier = String(describing: PreviewCategoryCell.self)
    
    // MARK: - Private UI Properties
    private let filmeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.color = .white
        indicator.style = .medium
        return indicator
    }()

    private let backgorundForLabels: UIView = {
        let element = UIView()
//        element.layer.cornerRadius = 8
        element.backgroundColor = .customDarkBlue
        element.alpha = 0.8
        return element
    }()

    private let nameCategoryLabel:UILabel = .makeLabel(font: UIFont.montserratSemiBold(ofSize: 14),
                                                       textColor: .white,
                                                       numberOfLines: 2
    )
    private let descriptionLabel:UILabel = .makeLabel(font: UIFont.montserratRegular(ofSize: 12),
                                                      textColor: .white,
                                                      numberOfLines: 1
    )
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellUI()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with model: Collections.Collection) {
        
        let defaultImage = UIImage(named: "defaultImage")
        self.nameCategoryLabel.text = model.name
        self.descriptionLabel.text = "\(model.moviesCount ?? 10) movies"
        
        guard
            let url = URL(string: model.cover?.url ?? "")
        else {
            filmeImage.image = defaultImage
            activityIndicator.stopAnimating()
            nameCategoryLabel.text = model.name
            descriptionLabel.text = "\(model.moviesCount ?? 0) movies"
            return
        }
        
        ImageDownloader.shared.downloadImage(from: url) { result in
            switch result {
                
            case .success(let image):
                self.filmeImage.image = image
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Setup UI
private extension PreviewCategoryCell {
    func setupCellUI() {
        contentView.backgroundColor = .customGrey
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16
    }
    
    func setupViews() {

        [filmeImage, backgorundForLabels].forEach { contentView.addSubview($0) }
        filmeImage.addSubview(activityIndicator)
        backgorundForLabels.addSubview(nameCategoryLabel)
        backgorundForLabels.addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        filmeImage.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        backgorundForLabels.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(filmeImage.snp.bottom)
            make.height.equalTo(60)
        }

        nameCategoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(descriptionLabel.snp.top).inset(-3)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(6)
            make.leading.equalToSuperview().inset(16)
        }
    }
}
