import UIKit

protocol SearchViewControllerProtocol: AnyObject {
    func reloadUpcomingMoviesCollection()
    func reloadRecentMoviesCollection()
}

final class SearchVC: UIViewController {

    //MARK: - Presenter
    var presenter: SearchPresenterProtocol!

    // MARK: - Private UI Properties

    /// First collection (above)
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

    /// Second collection (middle)
    private let upcomingMoviesPreviewView = CatergoriesSectionView(title: "Upcoming movie")

//    let searchCell = SearchCell(style: .default, reuseIdentifier: SearchCell.identifier)
//    let movieInfo = NetworkingManager.shared.getMovieDetails(for: 666) { result in
//        switch result {
//        case .success(let movieDetails):
//            print("Details for movie: \(movieDetails)")
//        case .failure(let error):
//            print("Error fetching movie details: \(error)")
//        }
//    }

    private lazy var upcomingMoviesCollectionView: UICollectionView = {
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
            PopularCategoryCell.self,
            forCellWithReuseIdentifier: PopularCategoryCell.identifier
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

    /// Third collection (below)
    private let recentMoviesPreviewView = CatergoriesSectionView(title: "Recent movie")

    private lazy var recentMoviesCollectionView: UICollectionView = {
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

    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstraints()
        presenter.setUpcomingMovies()
        presenter.setRecentMovies()
//        showPopularVC()
//        setupNavigationBar(with: searchBar)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        selectFirstCell()
    }

    // MARK: - Private methods

    private func showRecentVC() {
        recentMoviesPreviewView.seeAllButtonTapped = {
            self.presenter.showRecentMovies()
        }
    }

//    //MARK: - Private Methods
//    private func selectFirstCell(){
//        let selectedIndexPath = IndexPath(item: 0, section: 0)
//        categoryCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
//    }
}

//MARK: - UICollectionViewDataSource
#warning("что будет если поменять на дифбл?")
extension SearchVC: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch collectionView {
        case categoryCollectionView:
            return presenter.categoryData.count
        case upcomingMoviesCollectionView:
            return presenter.upcomingMovies.count
        case recentMoviesCollectionView:
            return presenter.recentMovies.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch collectionView {

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

        case upcomingMoviesCollectionView:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PopularCategoryCell.identifier,
                    for: indexPath) as? PopularCategoryCell
            else {
                return UICollectionViewCell()
            }
            cell.configure(with: presenter.upcomingMovies[indexPath.row])
            return cell

        case recentMoviesCollectionView:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PopularCategoryCell.identifier,
                    for: indexPath) as? PopularCategoryCell
            else {
                return UICollectionViewCell()
            }
            cell.configure(with: presenter.recentMovies[indexPath.item])
            return cell

        default:
            return UICollectionViewCell()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SearchVC: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch collectionView {
        case categoryCollectionView:
            return CGSize(width: 80, height: 31)
        case upcomingMoviesCollectionView:
            return CGSize(width: 135, height: 231)
        case recentMoviesCollectionView:
            return CGSize(width: 135, height: 231)
        default:
            return CGSize.zero
        }
    }
}

//MARK: - UICollectionViewDelegate
extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCell {
                cell.selectCell()
            }
        }

        if collectionView == upcomingMoviesPreviewView {
            let film = presenter.upcomingMovies[indexPath.row]
            presenter.showDetailsMovie(film.id ?? 0)
        }

        if collectionView == recentMoviesCollectionView {
            let film = presenter.recentMovies[indexPath.row]
            presenter.showDetailsMovie(film.id ?? 0)
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

// MARK: - SearchViewControllerProtocol
extension SearchVC: SearchViewControllerProtocol {

    func reloadUpcomingMoviesCollection() {
        DispatchQueue.main.async {
            self.upcomingMoviesCollectionView.reloadData()
        }
    }

    func reloadRecentMoviesCollection() {
        DispatchQueue.main.async {
            self.recentMoviesCollectionView.reloadData()
        }
    }
}

//MARK: - Setup UI
private extension SearchVC {

    func setViews() {
        view.backgroundColor = .clear
        self.view.addSubview(scrollView)
        [searchBar, categoryCollectionView, upcomingMoviesCollectionView, recentMoviesCollectionView, recentMoviesPreviewView, upcomingMoviesPreviewView].forEach { scrollView.addSubview($0)
        }
    }

    func setupConstraints(){

        let inset: CGFloat = 24

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        searchBar.snp.makeConstraints { make in
//            make.height.equalTo(41)
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(12)
        }

        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(12)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(39)
        }

        upcomingMoviesPreviewView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(inset)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        upcomingMoviesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(upcomingMoviesPreviewView.snp.bottom).offset(12)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(231)
        }

        recentMoviesPreviewView.snp.makeConstraints { make in
            make.top.equalTo(upcomingMoviesCollectionView.snp.bottom).offset(inset)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        recentMoviesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recentMoviesPreviewView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(231)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-inset)
        }
    }
}

// MARK: - Setup NavigationBar
#warning("dead code")
private extension SearchVC {
    func setupNavigationBar(with view: UIView) {
        let navBarAppearance = UINavigationBarAppearance()

        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.montserratSemiBold(ofSize: 16) ?? UIFont.systemFont(ofSize: 16),
        ]

        navBarAppearance.backgroundColor = .customBlack

        navigationController?.navigationBar.standardAppearance = navBarAppearance

        let customTitleView = createCustomTitleView(with: "Wanna search?")

//        navigationItem.titleView = customTitleView
        navigationItem.titleView = view
    }

    func createCustomTitleView(with name: String) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 40)

        let label = UILabel()
        label.text = name
        label.textColor = .white
        label.font = UIFont.montserratSemiBold(ofSize: 16)
        label.frame = CGRect(x: 55, y: 10, width: 200, height: 20)
        view.addSubview(label)
        return view
    }
}

