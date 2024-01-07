import UIKit

//protocol HomeViewControllerProtocol: AnyObject {
//    func setUserInfo(with user: User)
//}

final class HomeViewController: UIViewController {
    
    //MARK: - Presenter
//    var presenter: HomePresenterProtocol!
    
    private let avatarImage: UIImageView = {
       let element = UIImageView()
        element.backgroundColor = .customDarkGrey
        element.layer.cornerRadius = 20
        element.clipsToBounds = true
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    private let userNameLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.montserratSemiBold(ofSize: 16)
        element.textColor = .white
        element.numberOfLines = 1
        return element
    }()

    private lazy var priviewCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PreviewCategoryCell.self, forCellWithReuseIdentifier: PreviewCategoryCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return collectionView
    }()
    
    private let categoryView = CatergoriesSectionView(title: "Categories")
    
    private lazy var categoryCollectionView: UICollectionView = {
       let layot = UICollectionViewFlowLayout()
        layot.scrollDirection = .horizontal
        layot.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layot)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        return collectionView
    }()
    
    private let categoriesPreviewView = CatergoriesSectionView(title: "Most Popular")
    
    private lazy var categoryFilmCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PopularCategoryCell.self, forCellWithReuseIdentifier: PopularCategoryCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
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
    
    private let dataSource = StorageManager.shared
    
    private let filmsData = [
        MovieCellModel(image: nil, name: "Marvel", description: "40 best movies"),
        MovieCellModel(image: nil, name: "Marvel", description: "40 best movies"),
        MovieCellModel(image: nil, name: "Marvel", description: "40 best movies"),
    ]
    
    private let categoryData = [
        catergoriesModel(name: "All"),
        catergoriesModel(name: "Action"),
        catergoriesModel(name: "Comedy"),
        catergoriesModel(name: "Drama"),
        catergoriesModel(name: "Horror"),
        catergoriesModel(name: "Thriller"),
        catergoriesModel(name: "Animation"),
    ]
    
    private let categoriesFilmData = [
        PopularCategoryMovieCellModel(image: nil, name: "CgelovekPayk", ganre: "Action", rating: "4.9"),
        PopularCategoryMovieCellModel(image: nil, name: "CgelovekPayk", ganre: "Action", rating: "4.9"),
        PopularCategoryMovieCellModel(image: nil, name: "CgelovekPayk", ganre: "Action", rating: "4.9"),
        PopularCategoryMovieCellModel(image: nil, name: "CgelovekPayk", ganre: "Action", rating: "4.9"),
        PopularCategoryMovieCellModel(image: nil, name: "CgelovekPayk", ganre: "Action", rating: "4.9"),
    ]
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUserInfo(with: dataSource.fetchUser())
        selectFirstCell()
    }
    
    //MARK: - Private Methods
    private func setViews() {
        view.backgroundColor = .clear
        [avatarImage, userNameLabel, scrollView].forEach { self.view.addSubview($0) }
        [searchBar, priviewCollectionView, categoryView, categoryCollectionView, categoriesPreviewView, categoryFilmCollectionView].forEach { scrollView.addSubview($0) }
    }
    
    func setupUserInfo(with user: User?) {
        guard let user = user else { return }
        avatarImage.image = UIImage(data: user.image)
        userNameLabel.text = "Hello, " + user.fullName
    }
    
    private func selectFirstCell(){
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        categoryCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
    }
    
    private func setupConstraints(){
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
            make.width.equalTo(327)
            make.height.equalTo(41)
            make.top.equalTo(scrollView).offset(16)
            make.leading.trailing.equalTo(scrollView).inset(24)
        }
        
        priviewCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(24)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(154)
        }
        
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(priviewCollectionView.snp.bottom).offset(36)
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
    }
    
}


//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView{
        case priviewCollectionView:
            return filmsData.count
            
        case categoryCollectionView:
            return categoryData.count
            
        case categoryFilmCollectionView:
            return categoriesFilmData.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
        case priviewCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewCategoryCell.identifier, for: indexPath) as! PreviewCategoryCell
            cell.configure(with: filmsData[indexPath.item])
            return cell
            
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.identifier, for: indexPath) as! CategoriesCell
            cell.configure(with: categoryData[indexPath.item])
            cell.isSelected ? cell.selectCell() : cell.deselectCell()
            return cell
            
        case categoryFilmCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCategoryCell.identifier, for: indexPath) as! PopularCategoryCell
            cell.configure(with: categoriesFilmData[indexPath.item])
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}
//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        
        case priviewCollectionView:
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
extension HomeViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! CategoriesCell
            cell.selectCell()
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! CategoriesCell
            cell.deselectCell()
        default:
            break
        }
    }
}
