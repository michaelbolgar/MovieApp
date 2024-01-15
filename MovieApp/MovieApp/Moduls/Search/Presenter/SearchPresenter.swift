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
    //    var recentMovies: Results<MovieRecent> { get }
    var recentMovies: [MovieRecent] { get }
    
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
    //    var recentMovies: Results<MovieRecent>
    var recentMovies: [MovieRecent]
    
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
        
        // создаем массив в который инициализируем фильмы из реалма и переворачиваем
        let reversedMovies = Array(StorageManager.shared.realm.objects(MovieRecent.self)).reversed()
        // изменяем тип данных на [MovieRecent]
        let movieRecentArray: [MovieRecent] = Array(reversedMovies)
        // инициализируем фильмы
        recentMovies = movieRecentArray
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

    func setRecentMovies() {
        let movies = StorageManager.shared.realm.objects(MovieRecent.self)
        recentMovies = reverseMovies(movies)
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
    
    // метод для преобразования массива из realm в тип данных [MovieRecent]
    // и переворачивания массива
    private func reverseMovies(_ movies: Results<MovieRecent>) -> [MovieRecent] {
        let reversedMovies = Array(StorageManager.shared.realm.objects(MovieRecent.self)).reversed()
        let movieRecentArray: [MovieRecent] = Array(reversedMovies)
        return movieRecentArray
    }
    
    //    func showPopularMovies() {
    //        if !popularMovies.isEmpty {
    //            self.router.showPopularScreen(with: self.popularMovies)
    //        }
    //    }
}
