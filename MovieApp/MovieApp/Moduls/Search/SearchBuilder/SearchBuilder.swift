import UIKit

// MARK: - ModuleBuilderProtocol
protocol SearchBuilderProtocol {
    func createSearchModule(router: SearchRouterProtocol) -> UIViewController
    func createDetailsModule(_ movieId: Int) -> UIViewController
//    func createRecentModule(with movies: [MovieInfoForCell], and router: HomeRouterProtocol) -> UIViewController
}

// MARK: - ModuleBUilder
final class SearchBuilder: SearchBuilderProtocol {

    func createSearchModule(router: SearchRouterProtocol) -> UIViewController {
        let view = SearchVC()
//        let storageManager = StorageManager.shared            //использовать для последних фильмов или засунуть в UD?
        let networkingManager = NetworkingManager.shared
        let presenter = SearchPresenter(
            view: view,
//            storageManager: storageManager,
            router: router,
            networkingManager: networkingManager
        )
        view.presenter = presenter
        return view
    }

    func createDetailsModule(_ movieId: Int) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(movieId: movieId)
        presenter.view = view
        view.presenter = presenter
        return view
    }

//    func createRecentModule(with movies: [MovieInfoForCell] = [], and router: HomeRouterProtocol) -> UIViewController {
//        let view = PopularMovieViewController()
//        let presenter = PopularMoviePresenter(view: view, movies: movies, router: router)
//        view.presenter = presenter
//        return view
//    }
}

