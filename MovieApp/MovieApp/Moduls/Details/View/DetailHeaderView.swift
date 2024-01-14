import UIKit
import SnapKit

// MARK: - DetailHeaderView
final class DetailHeaderView: UIView {
    
    // MARK: - Properties
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(
                red: GradientConstants.redColor,
                green: GradientConstants.greenColor,
                blue: GradientConstants.blueColor,
                alpha: GradientConstants.alphaBegin
            ).cgColor,
            UIColor(
                red: GradientConstants.redColor,
                green: GradientConstants.greenColor,
                blue: GradientConstants.blueColor,
                alpha: GradientConstants.alphaEnd
            ).cgColor
        ]
        gradient.locations = [GradientConstants.gradientBegin, 
                              GradientConstants.gradientEnd]
        return gradient
    }()
    
    private lazy var posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var filmInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.spacing = LayoutConstants.filmInfoStackSpacing
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        return stack
    }()
    
    private var trailerClosure: (() -> Void)?
    private var shareClosure: (() -> Void)?
    private var movieClosure: (() -> Void)?
    
    private lazy var trailerButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = LayoutConstants.trailerRadius
        button.backgroundColor = .customOrange
        button.setTitle("  Trailer", for: .normal)
        let image = UIImage(systemName: Images.play)?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var movieButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = LayoutConstants.trailerRadius
        button.backgroundColor = .customOrange
        button.setTitle("  Movie", for: .normal)
        let image = UIImage(systemName: Images.play)?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = LayoutConstants.shareButtonSize / 2
        button.backgroundColor = .customDarkBlue
        button.setImage(UIImage(systemName: Images.share), for: .normal)
        return button
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func createLabeledIconView(
        title: Any,
        iconName: String,
        color: UIColor = .white,
        separator: Bool) -> UIView {
            
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: iconName)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.tintColor = color
            view.addSubview(imageView)
            
            let label = UILabel()
            label.text = "\(title)"
            label.textColor = color
            view.addSubview(label)
            
            imageView.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            
            label.snp.makeConstraints { make in
                make.leading.equalTo(
                    imageView.snp.trailing
                ).offset(
                    LayoutConstants.labelLeadingOffset
                )
                make.centerY.equalToSuperview()
                make.trailing.lessThanOrEqualToSuperview()
            }
            
            if separator {
                    let separator = UILabel()
                    separator.text = "|"
                    separator.textColor = color
                    view.addSubview(separator)
                    separator.snp.makeConstraints { make in
                        make.leading.equalTo(
                            label.snp.trailing
                        ).offset(
                            LayoutConstants.labelLeadingOffset
                        )
                        make.centerY.equalToSuperview()
                    }
                }
                return view
            }
    
    // MARK: - Layout and Configuration
    private func configure() {
        addSubview(backgroundImageView)
        layer.insertSublayer(gradientLayer, above: backgroundImageView.layer)
        [posterView, filmInfoStack, buttonStack].forEach {
            addSubview($0)
        }
        
        [trailerButton, movieButton, shareButton].forEach {
            buttonStack.addArrangedSubview($0)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        trailerButton.snp.makeConstraints {
            $0.width.equalTo(LayoutConstants.trailerButtonWidth)
            $0.height.equalTo(LayoutConstants.trailerButtonHeight)
        }
        
        movieButton.snp.makeConstraints {
            $0.width.equalTo(LayoutConstants.trailerButtonWidth)
            $0.height.equalTo(LayoutConstants.trailerButtonHeight)
        }
        
        shareButton.snp.makeConstraints {
            $0.width.height.equalTo(LayoutConstants.shareButtonSize)
        }
        
        posterView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(
                LayoutConstants.posterTopInset
            )
            make.leading.trailing.equalToSuperview().inset(
                LayoutConstants.posterLeadTralInset
            )
            make.height.equalTo(
                posterView.snp.width
            ).multipliedBy(
                LayoutConstants.posterHeightMultiplied
            )
        }
        
        filmInfoStack.snp.makeConstraints {
            $0.top.equalTo(
                posterView.snp.bottom
            ).offset(
                LayoutConstants.filmInfoStackTopOffset
            )
            $0.centerX.equalToSuperview()
            $0.width.lessThanOrEqualTo(
                safeAreaLayoutGuide.snp.width
            ).offset(
                LayoutConstants.filmInfoStackLeadingOffset
            )
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(
                filmInfoStack.snp.bottom
            ).offset(
                LayoutConstants.buttonStackTopOffset
            )
            $0.leading.trailing.equalToSuperview().inset(
                LayoutConstants.filmInfoStackLeadingOffset
            )
        }
    }
    
    // MARK: - @objc
    @objc func trailerButtonTapped() {
        trailerClosure?()
    }
    
    @objc func movieButtonTapped() {
        movieClosure?()
    }
    
    @objc func shareButtonTapped() {
        shareClosure?()
    }
}

// MARK: - DetailHeaderView+Configurable
extension DetailHeaderView: Configurable {
    struct Model {
        let imageURL: String?
        let duration: Int?
        let genre: String?
        let rating: Double?
        let year: Int?
        let trailerClosure: () -> Void
        let movieClosure: () -> Void
        let shareClosure: () -> Void
    }
    
    func update(model: Model) {
        trailerButton.addTarget(
            self,
            action: #selector(
                trailerButtonTapped
            ),
            for: .touchUpInside
        )
        shareButton.addTarget(
            self, action: #selector(
                shareButtonTapped
            ), for: .touchUpInside
        )
        movieButton.addTarget(
            self, action: #selector(
                movieButtonTapped
            ), for: .touchUpInside
        )
        
        trailerClosure = model.trailerClosure
        shareClosure = model.shareClosure
        movieClosure = model.movieClosure
        
        filmInfoStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let yearView = createLabeledIconView(
            title: model.year ?? "",
            iconName: Images.calendar,
            separator: true
        )
        let durationView = createLabeledIconView(
            title: model.duration ?? "",
            iconName: Images.clock,
            separator: true
        )
        let genreView = createLabeledIconView(
            title: model.genre ?? "",
            iconName: Images.action, separator: false
        )
        let ratingView = createLabeledIconView(
            title: model.rating ?? "",
            iconName: Images.rating,
            color: UIColor.customOrange,
            separator: false
        )
        
        addSubview(ratingView)
        ratingView.snp.makeConstraints {
            $0.top.equalTo(
                filmInfoStack.snp.bottom
            ).offset(
                LayoutConstants.filmInfoStackTopOffset
            )
            $0.centerX.equalToSuperview()
        }
        
        [yearView, durationView, genreView].forEach {
            filmInfoStack.addArrangedSubview($0)
        }
        
        guard let imageURL = model.imageURL, 
                let url = URL(string: imageURL) else { return }
        
        ImageDownloader.shared.downloadImage(from: url) { result in
            switch result {
            case .success(let image):
                self.posterView.image = image
                self.backgroundImageView.image = image
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - LayoutConstants
private enum LayoutConstants {
    static let trailerRadius: CGFloat = 20
    static let filmInfoStackSpacing: CGFloat = 25
    static let labelLeadingOffset: CGFloat = 8
    static let trailerButtonWidth: CGFloat = 115
    static let trailerButtonHeight: CGFloat = 48
    static let shareButtonSize: CGFloat = 48
    static let posterTopInset: CGFloat = 150
    static let posterLeadTralInset: CGFloat = 16
    static let posterHeightMultiplied: CGFloat = 0.85
    static let filmInfoStackTopOffset: CGFloat = 50
    static let filmInfoStackLeadingOffset: CGFloat = 30
    static let buttonStackTopOffset: CGFloat = 80
}

// MARK: - GradientConstants
private enum GradientConstants {
    static let redColor: CGFloat = 31/255
    static let greenColor: CGFloat = 29/255
    static let blueColor: CGFloat = 43/255
    static let alphaBegin: CGFloat = 0.7
    static let alphaEnd: CGFloat = 1
    static let gradientBegin: NSNumber = 0
    static let gradientEnd: NSNumber = 1
}

// MARK: - Images
private enum Images {
    static let calendar = "calendar"
    static let clock = "clock.fill"
    static let action = "film.fill"
    static let rating = "star.fill"
    static let share = "square.and.arrow.up"
    static let play = "play.fill"
}
