import UIKit

// MARK: - RouterMain
protocol RouterSearchProtocol {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: SearchBuilderProtocol? { get set }
}

// MARK: - ProfileRouterProtocol
protocol SearchRouterProtocol: RouterSearchProtocol {
    func initialViewController()
    func showDetails(_ movieId: Int)
//    func showRecentScreen(with movies: [MovieInfoForCell])
//    func updateRecentScreen(with movies: [MovieInfoForCell])
}

// MARK: - ProfileRouter
final class SearchRouter: SearchRouterProtocol {
    var navigationController: UINavigationController?
    var moduleBuilder: SearchBuilderProtocol?

    init(navigationController: UINavigationController, moduleBuilder: SearchBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard
                let searchVC = moduleBuilder?.createSearchModule(router: self)
            else {
                return
            }
            navigationController.viewControllers = [searchVC]
        }
    }

    func showDetails(_ movieId: Int) {
        if let navigationController = navigationController {
            guard let detailsVC = moduleBuilder?.createDetailsModule(movieId) else { return }
            navigationController.pushViewController(detailsVC, animated: true)
        }
    }

//    func showPopularScreen(with movies: [MovieInfoForCell] = []) {
//        if let navigationController = navigationController {
//            guard let popularVC = moduleBuilder?.createPopularModule(with: movies, and: self) else { return }
//            navigationController.pushViewController(popularVC, animated: true)
//        }
//    }
//
//    func updatePopularScreen(with movies: [MovieInfoForCell]) {
//        if let navigationController = navigationController,
//           let popularVC = navigationController.viewControllers.last as? PopularMovieViewController {
//            popularVC.presenter.movies = movies
//                popularVC.presenter.updateData()
//        }
//    }
}

