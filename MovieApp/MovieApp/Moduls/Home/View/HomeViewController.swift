import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func setUserInfo(with user: User)
    func reloadPreviewCollection()
    func reloadPopularCollection()
}

final class HomeViewController: UIViewController {
    
    //MARK: - Presenter
    var presenter: HomePresenterProtocol!
    
    // MARK: - Private UI Properties
    private let avatarImage: UIImageView = {
        let element = UIImageView()
        element.backgroundColor = .customDarkGrey
        element.layer.cornerRadius = 20
        element.clipsToBounds = true
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    private let userNameLabel = UILabel.makeLabel(
        text: "",
        font: UIFont.montserratSemiBold(ofSize: 16),
        textColor: .white,
        numberOfLines: 1
    )
    
    private lazy var previewCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            PreviewCategoryCell.self,
            forCellWithReuseIdentifier: PreviewCategoryCell.identifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: 20,
            bottom: 0,
            right: 20
        )
        return collectionView
    }()
    
    private let categoryView = CatergoriesSectionView(title: "Categories")
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layot = UICollectionViewFlowLayout()
        layot.scrollDirection = .horizontal
        layot.minimumLineSpacing = 8
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layot
        )
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            CategoriesCell.self,
            forCellWithReuseIdentifier: CategoriesCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: 24,
            bottom: 0,
            right: 24
        )
        return collectionView
    }()
    
    private let categoriesPreviewView = CatergoriesSectionView(title: "Most Popular")
    
    private lazy var categoryFilmCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            PopularCategoryCell.self,
            forCellWithReuseIdentifier: PopularCategoryCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: 24,
            bottom: 0,
            right: 24
        )
        return collectionView
    }()
    
    private let scrollView: UIScrollView = {
        let element = UIScrollView()
        element.backgroundColor = .clear
        element.showsVerticalScrollIndicator = false
        element.alwaysBounceVertical = true
        return element
    }()
    
    private let searchBar: SearchBarView = {
        let element = SearchBarView()
        element.backgroundColor = .customGrey
        return element
    }()
    
    private let favoriteView: UIView = {
        var view = UIView()
        view.backgroundColor = .customGrey
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var favoritesButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.tintColor = .customRed
        button.addTarget(
            self,
            action: #selector(favoritesButtonDidTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstraints()
        presenter.setUser()
        presenter.setSelections()
        presenter.setPopularMovies()
        showPopularVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectFirstCell()
    }
    
    // MARK: - Private Actions
    @objc private func favoritesButtonDidTapped() {
        presenter.showFavoritesScreen()
    }
    
    private func showPopularVC() {
        categoriesPreviewView.seeAllButtonTapped = {
            self.presenter.showPopularMovies()
        }
    }
    
    //MARK: - Private Methods
    private func selectFirstCell(){
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        categoryCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case previewCollectionView:
            return presenter.selections.count
        case categoryCollectionView:
            return presenter.categoryData.count
        case categoryFilmCollectionView:
            return presenter.popularMovies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case previewCollectionView:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PreviewCategoryCell.identifier,
                    for: indexPath) as? PreviewCategoryCell
            else {
                return UICollectionViewCell()
            }
            cell.configure(with: presenter.selections[indexPath.row])
            return cell
            
        case categoryCollectionView:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CategoriesCell.identifier,
                    for: indexPath) as? CategoriesCell
            else {
                return UICollectionViewCell()
            }
            cell.configure(with: presenter.categoryData[indexPath.item])
            cell.isSelected ? cell.selectCell() : cell.deselectCell()
            return cell
            
        case categoryFilmCollectionView:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PopularCategoryCell.identifier,
                    for: indexPath) as? PopularCategoryCell
            else {
                return UICollectionViewCell()
            }
            cell.configure(with: presenter.popularMovies[indexPath.item])
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case previewCollectionView:
            return CGSize(width: 295, height: 154)
        case categoryCollectionView:
            return CGSize(width: 80, height: 31)
        case categoryFilmCollectionView:
            return CGSize(width: 135, height: 231)
        default:
            return CGSize.zero
        }
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCell {
                cell.selectCell()
            }
        }
        
        if collectionView == categoryFilmCollectionView {
            let film = presenter.popularMovies[indexPath.row]
            presenter.showDetailsMovie(film.id ?? 0)
        }
        
        if collectionView == previewCollectionView {
            let collection = presenter.selections[indexPath.row]
            presenter.showCollectionMovies(with: collection.slug ?? "")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCell {
                cell.deselectCell()
            }
        }
    }
}

// MARK: - HomeViewControllerProtocol
extension HomeViewController: HomeViewControllerProtocol {
    func setUserInfo(with user: User) {
        avatarImage.image = UIImage(data: user.image)
        userNameLabel.text = "Hello, " + user.fullName
    }
    
    func reloadPreviewCollection() {
        DispatchQueue.main.async {
            self.previewCollectionView.reloadData()
        }
    }
    
    func reloadPopularCollection() {
        DispatchQueue.main.async {
            self.categoryFilmCollectionView.reloadData()
        }
    }
}

//MARK: - Setup UI
private extension HomeViewController{
    
    func setViews() {
        view.backgroundColor = .clear
        favoriteView.addSubview(favoritesButton)
        [avatarImage, userNameLabel, scrollView, favoriteView].forEach { self.view.addSubview($0)
        }
        [searchBar, previewCollectionView, categoryView, categoryCollectionView, categoriesPreviewView, categoryFilmCollectionView].forEach { scrollView.addSubview($0)
        }
    }
    
    func setupConstraints(){
        avatarImage.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.equalToSuperview().offset(24)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImage)
            make.leading.equalTo(avatarImage.snp.trailing).offset(17)
            make.trailing.equalToSuperview().inset(80)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        searchBar.snp.makeConstraints { make in
#warning("тут явно надо что-то исправить, но после того как порефакторим сам searchBar")
            make.height.equalTo(41)
            make.top.equalTo(scrollView).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        previewCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(24)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(154)
        }
        
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(previewCollectionView.snp.bottom).offset(36)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom).offset(15)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(39)
        }
        
        categoriesPreviewView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(24)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        categoryFilmCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoriesPreviewView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(231)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-25)
        }
        
        favoriteView.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImage.snp.centerY)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        
        favoritesButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.trailing.equalToSuperview().offset(-4)
        }
    }
}


