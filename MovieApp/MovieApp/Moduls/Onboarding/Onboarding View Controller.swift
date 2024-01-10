import UIKit

struct OnboardingStruct {
    let image: UIImage
}

final class OnboardingViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .customBlue
        button.layer.cornerRadius = 10
        button.setTitle(">", for: .normal)
        button.tintColor = .customBlack
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        pageControl.isEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .customBlue
        return pageControl
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = .montserratSemiBold(ofSize: 18)
        label.textColor = .white
        label.text = "Lorem ipsum dolor sit amet consecteur esplicit"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = .montserratMedium(ofSize: 14)
        label.textColor = .customGrey
        label.text = "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient. "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var onboardingArray = [OnboardingStruct]()
    private var collectionItem = 0
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        view.backgroundColor = .customBlack
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        view.addSubview(collectionView)
        view.addSubview(topLabel)
        view.addSubview(bottomLabel)
        
        topLabel.numberOfLines = 2
        topLabel.textAlignment = .center
        bottomLabel.textAlignment = .center
        bottomLabel.numberOfLines = 4
        
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        
        guard let imageFirst = UIImage(named: "onboarding1"),
              let imageSecond = UIImage(named: "onboarding1"),
              let imageThird = UIImage(named: "onboarding3") else {
            return
        }
        
        let firstScreen = OnboardingStruct(image: imageFirst)
        let secondScreen = OnboardingStruct(image: imageSecond)
        let thirdScreen = OnboardingStruct(image: imageThird)
        onboardingArray = [firstScreen, secondScreen, thirdScreen]
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc private func nextButtonTapped() {
        
        if collectionItem == 1 {
            nextButton.setTitle(">", for: .normal)
        }
        
        if collectionItem == 2 {
            saveUserDefaults()
            dismiss(animated: true, completion: nil)
        } else {
            collectionItem += 1
            let index: IndexPath = [0 , collectionItem]
            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = collectionItem
        }
    }
    
    private func saveUserDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "OnBoardingWasViewed")
    }
}

//MARK: - UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        let model = onboardingArray[indexPath.row]
        cell.cellConfigure(model: model)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
}

//MARK: - setConstraints
extension OnboardingViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 400),
            
            topLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 50),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
            bottomLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -65),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            nextButton.widthAnchor.constraint(equalToConstant: 60),
            
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            pageControl.heightAnchor.constraint(equalToConstant: 30),
            
        ])
    }
}
