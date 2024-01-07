import UIKit

// MARK: - Constants
#warning("здесь и в других view -- что значит 'Title'? это название не даёт понимания, что содержит енам")
#warning("зачем в енаме одновременно и картинки, и отступы, и цвета?")
/*
 1) весь этот большой енам лучше разделить на несколько. Отступы однозначно лучше перенести в то место, где они используются -- к вёрстке в configure(). Во-первых, они тогда будут на своём месте, во-вторых не будут мозолить глаза. В целом, редко используемые сущности (а тут всё используется по одному разу) можно смело уносить вниз, оставляя наверху только самое важное/наиболее используемое
 2) Другой отдельной сущностью я бы сделал настройку градиента
 3) Картинки как минимум стоит сгруппировать в отдельную сущность (опять-таки: принцип единой ответственности), как максимум -- вообще убрать и использовать напрямую "clock.fill" и тд. Каждый из этих объектов используется один раз, то есть ты делаешь две строки кода вместо одной, а разницы особой нет, поскольку названия у дефолтных картинок и так говорящие
 */
private enum Titles {
    static let calendar = "calendar"
    static let clock = "clock.fill"
    static let action = "film.fill"
    static let rating = "star.fill"
    static let share = "square.and.arrow.up"
    static let play = "play.fill"
    static let buttonTitle = "  Trailer"
    static let redColor: CGFloat = 31/255
    static let greenColor: CGFloat = 29/255
    static let blueColor: CGFloat = 43/255
    static let alphaBegin: CGFloat = 0.7
    static let alphaEnd: CGFloat = 1
    static let gradientBegin: NSNumber = 0
    static let gradientEnd: NSNumber = 1
    static let trailerRadius: CGFloat = 20
    static let separatorWidth: CGFloat = 3
    static let separatorHeight: CGFloat = 10
    static let filmInfoStackSpacing: CGFloat = 25
    static let labelLeadingOffset: CGFloat = 8
    static let trailerButtonWidth: CGFloat = 115
    static let trailerButtonHeight: CGFloat = 48
    static let shareButtonSize: CGFloat = 48
    static let posterTopInset: CGFloat = 80
    static let posterLeadTralInset: CGFloat = 16
    static let posterHeightMultiplied: CGFloat = 0.85
    static let filmInfoStackTopOffset: CGFloat = 50
    static let filmInfoStackLeadingOffset: CGFloat = 30
    static let buttonStackLeadingOffset: CGFloat = 70
    static let buttonStackTopOffset: CGFloat = 80
}

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
                red: Titles.redColor,
                green: Titles.greenColor,
                blue: Titles.blueColor,
                alpha: Titles.alphaBegin
            ).cgColor,
            UIColor(
                red: Titles.redColor,
                green: Titles.greenColor,
                blue: Titles.blueColor,
                alpha: Titles.alphaEnd
            ).cgColor
        ]
        gradient.locations = [Titles.gradientBegin, Titles.gradientEnd]
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
        stack.spacing = Titles.filmInfoStackSpacing
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
    
    private lazy var trailerButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = Titles.trailerRadius
        button.backgroundColor = .customOrange
        button.setTitle(Titles.buttonTitle, for: .normal)
        let image = UIImage(systemName: Titles.play)?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        return button
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = Titles.shareButtonSize / 2
        button.backgroundColor = .customDarkBlue
        button.setImage(UIImage(systemName: Titles.share), for: .normal)
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
    
    private func createSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.snp.makeConstraints { make in
            make.width.equalTo(Titles.separatorWidth)
            make.height.equalTo(Titles.separatorHeight)
        }
        return separator
    }
    
    private func createLabeledIconView(
        title: String,
        iconName: String,
        color: UIColor = .white) -> UIView {
            
        let view = UIView()
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: iconName)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = color
        view.addSubview(imageView)
        
        let label = UILabel()
        label.text = title
        label.textColor = color
        view.addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(Titles.labelLeadingOffset)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
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
        
        [trailerButton, shareButton].forEach {
            buttonStack.addArrangedSubview($0)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        trailerButton.snp.makeConstraints {
            $0.width.equalTo(Titles.trailerButtonWidth)
            $0.height.equalTo(Titles.trailerButtonHeight)
        }
        
        shareButton.snp.makeConstraints {
            $0.width.height.equalTo(Titles.shareButtonSize)
        }
        
        posterView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Titles.posterTopInset)
            make.leading.trailing.equalToSuperview().inset(Titles.posterLeadTralInset)
            make.height.equalTo(posterView.snp.width).multipliedBy(Titles.posterHeightMultiplied)
        }
        
        filmInfoStack.snp.makeConstraints {
            $0.top.equalTo(posterView.snp.bottom).offset(Titles.filmInfoStackTopOffset)
            $0.centerX.equalToSuperview() // This will center it horizontally
                $0.width.lessThanOrEqualTo(safeAreaLayoutGuide.snp.width).offset(Titles.filmInfoStackLeadingOffset)
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(filmInfoStack.snp.bottom).offset(Titles.buttonStackTopOffset)
            $0.leading.trailing.equalToSuperview().inset(Titles.filmInfoStackLeadingOffset)
        }
    }
    
    // MARK: - @objc
    @objc func trailerButtonTapped() {
        trailerClosure?()
    }
    
    @objc func shareButtonTapped() {
        shareClosure?()
    }
}

// MARK: - DetailHeaderView+Configurable
extension DetailHeaderView: Configurable {
    struct Model {
        let imageURL: String?
        let duration: String?
        let genre: String?
        let rating: String?
        let year: String?
        let trailerClosure: () -> Void
        let shareClosure: () -> Void
    }
    
    func update(model: Model) {
        trailerButton.addTarget(self, action: #selector(trailerButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
        trailerClosure = model.trailerClosure
        shareClosure = model.shareClosure
        
        filmInfoStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let yearView = createLabeledIconView(title: model.year ?? "", iconName: Titles.calendar)
        let durationView = createLabeledIconView(title: model.duration ?? "", iconName: Titles.clock)
        let genreView = createLabeledIconView(title: model.genre ?? "", iconName: Titles.action)
        let ratingView = createLabeledIconView(title: model.rating ?? "", iconName: Titles.rating, color: UIColor.customOrange)
        
        addSubview(ratingView)
                ratingView.snp.makeConstraints {
                    $0.top.equalTo(filmInfoStack.snp.bottom).offset(Titles.filmInfoStackTopOffset)
                    $0.centerX.equalToSuperview()
                    // Установите любые другие констрейнты, которые необходимы для ratingView
                }
        
        [yearView, durationView, genreView].forEach {
            filmInfoStack.addArrangedSubview($0)
        }
        
        guard let imageURL = model.imageURL, let url = URL(string: imageURL) else {
            posterView.image = nil
            return
        }
        
//        URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
//            guard let self = self else { return }
//
//            if let error = error {
//                // Обработка ошибки загрузки
//                print("Ошибка загрузки изображения: \(error.localizedDescription)")
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                print("Некорректный ответ сервера")
//                return
//            }
//
//            guard let data = data, let image = UIImage(data: data) else {
//                print("Данные не могут быть преобразованы в изображение")
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.posterView.image = image
//            }
//        }.resume()
        posterView.image = UIImage(named: "Bg")
        backgroundImageView.image = UIImage(named: "Bg")
    }
}
