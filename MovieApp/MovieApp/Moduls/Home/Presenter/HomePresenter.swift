import UIKit

protocol HomePresenterProtocol {
    init(
        view: HomeViewControllerProtocol,
        storageManager: StorageManagerProtocol,
        router: HomeRouterProtocol,
        networkingManager: NetworkingManager
    )
    
    var categoryData: [CatergoriesModel] { get }
    var selections: [Collections.Collection] { get }
    var popularMovies: [MovieInfoForCell] { get }

    func setUser()
    func showFavoritesScreen()
    func setSelections()
    func setPopularMovies()
    
    func showDetailsMovie(_ movieId: Int)
    func showPopularMovies()
    func showCollectionMovies(with slug: String)
}

final class HomePresenter: HomePresenterProtocol {
    
    private weak var view: HomeViewControllerProtocol?
    private let dataSource: StorageManagerProtocol
    private let router: HomeRouterProtocol
    private let networkingManager: NetworkingManager
    
    var selections: [Collections.Collection] = []
    var popularMovies: [MovieInfoForCell] = []

    //MARK: - Mock data
    
    var categoryData = [
        CatergoriesModel(name: "Action"),
        CatergoriesModel(name: "Comedy"),
        CatergoriesModel(name: "Horror"),
        CatergoriesModel(name: "Drama"),
        CatergoriesModel(name: "Anime"),
        CatergoriesModel(name: "Cartoon"),
    ]
    
    init(view: HomeViewControllerProtocol, storageManager: StorageManagerProtocol, router: HomeRouterProtocol, networkingManager: NetworkingManager) {
        self.view = view
        self.dataSource = storageManager
        self.router = router
        self.networkingManager = networkingManager
    }
    
    // realm
    func setUser() {
        guard let user = dataSource.fetchUser() else { return }
        view?.setUserInfo(with: user)
    }
    
    
    // network layer
    func setSelections() {
        networkingManager.getCollections { result in
            switch result {
                
            case .success(let collections):
                self.selections = collections.docs
                
                self.view?.reloadPreviewCollection()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setPopularMovies() {
        networkingManager.getPopular { result in
            switch result {
                
            case .success(let movies):
                self.popularMovies = movies.docs
                self.view?.reloadPopularCollection()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // navigation
    func showFavoritesScreen() {
        router.showFavorites()
    }
    
    func showDetailsMovie(_ movieId: Int) {
        router.showDetails(movieId)
    }
    
    func showPopularMovies() {
        if !popularMovies.isEmpty {
            self.router.showPopularScreen(with: self.popularMovies)
        }
    }
    
    func showCollectionMovies(with slug: String) {
        router.showPopularScreen(with: [])
        networkingManager.getColletionMovieList(for: slug) { result in
            switch result {
                
            case .success(let movies):
                DispatchQueue.main.async {
                    self.router.updatePopularScreen(with: movies.docs)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
