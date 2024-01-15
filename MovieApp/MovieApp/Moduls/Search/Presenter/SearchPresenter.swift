import UIKit
import RealmSwift

protocol SearchPresenterProtocol {
    init(
        view: SearchViewControllerProtocol,
//        storageManager: StorageManagerProtocol,
        router: SearchRouterProtocol,
        networkingManager: NetworkingManager
    )

    var categoryData: [CatergoriesModel] { get }
    var upcomingMovies: [MovieInfoForCell] { get }
    var recentMovies: Results<MovieRecent> { get }

    func setUpcomingMovies()
    func setRecentMovies()
    func reloadRecentMovies()

    func showRecentMovies()
    func showDetailsMovie(_ movieId: Int)
    func showSearchScreen()
}

final class SearchPresenter: SearchPresenterProtocol {

    private weak var view: SearchViewControllerProtocol?
//    private let dataSource: StorageManagerProtocol
    private let router: SearchRouterProtocol
    private let networkingManager: NetworkingManager

    var upcomingMovies: [MovieInfoForCell] = []
    var recentMovies: Results<MovieRecent>

    //MARK: - Mock data

    var categoryData = [
        CatergoriesModel(name: "Action"),
        CatergoriesModel(name: "Comedy"),
        CatergoriesModel(name: "Drama"),
        CatergoriesModel(name: "Horror"),
        CatergoriesModel(name: "Anime"),
        CatergoriesModel(name: "Animation"),
    ]

    init(view: SearchViewControllerProtocol, /*storageManager: StorageManagerProtocol,*/ router: SearchRouterProtocol, networkingManager: NetworkingManager) {
        self.view = view
//        self.dataSource = storageManager
        self.router = router
        self.networkingManager = networkingManager
        recentMovies = StorageManager.shared.realm.objects(MovieRecent.self)


    }

    /// Network layer
    func setUpcomingMovies() {
        networkingManager.getUpcoming{ result in
            switch result {

            case .success(let movies):
                self.upcomingMovies = movies.docs
                self.view?.reloadUpcomingMoviesCollection()
            case .failure(let error):
                print(error)
            }
        }
    }

#warning("заменить на реальный запрос, пока что тянутся популярные чтобы заполнить контент")
    func setRecentMovies() {
//        networkingManager.getPopular { result in
//            switch result {
//
//            case .success(let movies):
//                self.recentMovies = movies.docs
//                self.view?.reloadRecentMoviesCollection()
//            case .failure(let error):
//                print(error)
//            }
//        }
        recentMovies = StorageManager.shared.realm.objects(MovieRecent.self)
    }

    /// Navigation
    func showRecentMovies() {
        print("чтобы запушить экран, нужно его создать, а у нас лэйаута нет")
        //см.пример ниже как идёт проверка на пустой экран
    }

    func showSearchScreen() {
        print("чтобы запушить экран, нужно его создать, а у нас лэйаута нет")
        //см.пример ниже как идёт проверка на пустой экран
    }

    func showDetailsMovie(_ movieId: Int) {
        router.showDetails(movieId)
    }
    
    func reloadRecentMovies() {
        view?.reloadRecentMoviesCollection()
    }

//    func showPopularMovies() {
//        if !popularMovies.isEmpty {
//            self.router.showPopularScreen(with: self.popularMovies)
//        }
//    }
}
