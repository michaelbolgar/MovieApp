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
    var popularMovies: [PopularMovies.PopularMovie] { get }
    
    func setUser()
    func showFavoritesScreen()
    func setSelections()
    func setPopularMovies()
}

final class HomePresenter: HomePresenterProtocol {
    
    private weak var view: HomeViewControllerProtocol?
    private let dataSource: StorageManagerProtocol
    private let router: HomeRouterProtocol
    private let networkingManager: NetworkingManager
    
    var selections: [Collections.Collection] = []
    var popularMovies: [PopularMovies.PopularMovie] = []
    
    //MARK: - Mock data
    
    var categoryData = [
        CatergoriesModel(name: "All"),
        CatergoriesModel(name: "Action"),
        CatergoriesModel(name: "Comedy"),
        CatergoriesModel(name: "Drama"),
        CatergoriesModel(name: "Horror"),
        CatergoriesModel(name: "Thriller"),
        CatergoriesModel(name: "Animation"),
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
                print(self.popularMovies)
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
}
