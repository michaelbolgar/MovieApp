import UIKit
import SnapKit

/// this cell is only been used for the collection 'Upcoming soon' on the Search screen

final class UpcomingCell: UICollectionViewCell {

    // MARK: - Network Properties
    private var task: URLSessionDataTask?
    private var imageUrl: URL?

    //MARK: - Properties
    static let identifier = String(describing: UpcomingCell.self)

    // MARK: - Private UI Properties
    private let filmeImage: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
        element.layer.cornerRadius = 10
        return element
    }()

    private let calenderImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "calendar")
        element.tintColor = .customDarkGrey
        return element
    }()

    private let timeImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "clock.fill")
        element.tintColor = .customDarkGrey
        return element
    }()

    private let ganreImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "film.fill")
        element.tintColor = .customDarkGrey
        return element
    }()

    private let filmNameLabel = UILabel.makeLabel(font: UIFont.montserratSemiBold(ofSize: 16),
                                                  textColor: .white,
                                                  numberOfLines: 2
    )

    private let ageLimitView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.cyan.cgColor
        return view
    }()

    private let ageLimitLabel: UILabel = {
        let element = UILabel.makeLabel(font: UIFont.montserratMedium(ofSize: 12),
                                        textColor: .cyan,
                                        numberOfLines: 1
        )
        element.textAlignment = .center
        return element
    }()

    private let yearPublishedLabel = UILabel.makeLabel(font: UIFont.montserratMedium(ofSize: 12),
                                                       textColor: .customDarkGrey,
                                                       numberOfLines: 1
    )

    private let timeLabel = UILabel.makeLabel(font: UIFont.montserratMedium(ofSize: 12),
                                              textColor: .customDarkGrey,
                                              numberOfLines: 1
    )

    private let ganreLabel = UILabel.makeLabel(font: UIFont.montserratMedium(ofSize: 12),
                                               textColor: .customDarkGrey,
                                               numberOfLines: 1
    )

    private let typeLabel = UILabel .makeLabel(font: UIFont.montserratMedium(ofSize: 12),
                                               textColor: .white,
                                               numberOfLines: 1
    )

    private lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .medium
        indicator.color = .white
        return indicator
    }()

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        filmeImage.image = nil
        activityIndicator.stopAnimating()
        task?.cancel()
    }

    // MARK: - Public Methods
    func configure(with model: MovieInfoForCell) {

        task?.cancel()

        activityIndicator.startAnimating()
        setupUI(with: model)

        guard let urlString = model.poster?.url, let url = URL(string: urlString) else {
            filmeImage.image = nil
            return
        }

        /// checking if an image is already downloaded
        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            filmeImage.image = cachedImage
            activityIndicator.stopAnimating()
            return
        }

        /// downloading of film poster
        imageUrl = url
        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, self.imageUrl == url else { return }

            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    ImageCache.shared.save(image: image, forKey: urlString)
                    self.filmeImage.image = image
                } else {
//                    self.filmeImage.image = nil
                    self.filmeImage.image = UIImage(named: "DoctorWho")
                }
                self.activityIndicator.stopAnimating()
            }
        }
        task?.resume()
    }

    // MARK: - Private Methods
    private func setupUI(with movie: MovieInfoForCell) {
        filmNameLabel.text = movie.name
#warning("почему в ageLimitLabel хардкод? проверить другие ячейки")
        ageLimitLabel.text = "PG-13"
        let year = movie.year?.formatted()
#warning("что это")
        let newYear = year?.replacingOccurrences(of: ",", with: "")
        yearPublishedLabel.text = newYear
        timeLabel.text = "\(movie.movieLength ?? 0) minutes"
        ganreLabel.text = (movie.genres?.first?.name ?? "") + "  |"
        typeLabel.text = movie.type
    }
}

// MARK: - Setup UI
private extension UpcomingCell {
    func setupViews() {
        contentView.backgroundColor = .customBlack
        filmeImage.addSubview(activityIndicator)
        ageLimitView.addSubview(ageLimitLabel)
        [filmeImage, filmNameLabel,
         yearPublishedLabel, timeLabel, ageLimitView, ganreLabel, typeLabel,
         calenderImage, timeImage, ganreImage].forEach { contentView.addSubview($0)}
    }

    func setupConstraints() {
        filmeImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(24)
            make.width.equalTo(112)
        }

        filmNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalTo(filmeImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(12)
        }

        calenderImage.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalTo(filmNameLabel)
            make.top.equalTo(filmNameLabel.snp.bottom).offset(12)
        }

        yearPublishedLabel.snp.makeConstraints { make in
            make.leading.equalTo(calenderImage.snp.trailing).offset(4)
            make.centerY.equalTo(calenderImage)
        }

        timeImage.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalTo(calenderImage)
            make.top.equalTo(calenderImage.snp.bottom).offset(14)
        }

        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(timeImage.snp.trailing).offset(4)
            make.centerY.equalTo(timeImage)
        }

        ageLimitView.snp.makeConstraints { make in
            make.leading.equalTo(timeLabel.snp.trailing).offset(12)
            make.centerY.equalTo(timeLabel)
            make.width.equalTo(43)
            make.height.equalTo(20)
        }

        ageLimitLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalToSuperview().offset(-2)
            make.top.equalToSuperview().offset(2)
            make.bottom.equalToSuperview().offset(-2)
        }

        ganreImage.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalTo(timeImage)
            make.top.equalTo(timeImage.snp.bottom).offset(14)
        }

        ganreLabel.snp.makeConstraints { make in
            make.leading.equalTo(ganreImage.snp.trailing).offset(4)
            make.centerY.equalTo(ganreImage)
        }

        typeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ganreImage)
            make.leading.equalTo(ganreLabel.snp.trailing).offset(8)
        }

        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
