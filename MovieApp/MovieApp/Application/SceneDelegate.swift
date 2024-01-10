import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let factory: AppFactory = Factory()

    #warning("убрать force unwrap")
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let rootRouter = factory.makeRootRouter(window!)
        rootRouter.start()

        let window = UIWindow(windowScene: windowScene)
        detailsRequest()

        // Define the detailsRequest function
        func detailsRequest() {
            let movieID = 666
            NetworkingManager.shared.getMovieDetails(for: movieID) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let movieDetails):
                        self?.window?.rootViewController = makeScreen(movieDetails: movieDetails)
                        self?.window?.makeKeyAndVisible()
                    case .failure(let error):
                        print("Error fetching movie details: \(error)")
                    }
                }
            }
        }

        // Define the makeScreen function
        func makeScreen(movieDetails: MovieDetails) -> UIViewController {
            let controller = DetailViewController()
            let presenter = DetailPresenter(movieDetails)

            controller.presenter = presenter
            presenter.view = controller

            return controller
        }

        self.window = window
        //три разных экрана
//        window.rootViewController = UINavigationController(rootViewController: ViewController())
//        window.rootViewController = MainTabBarController()
//        let navigationController = UINavigationController()

        //экран details
//        func makeScreen() -> UIViewController {
//                            let controller = DetailViewController()
//                            let presenter = DetailPresenter()
//
//                            controller.presenter = presenter
//                            presenter.view = controller
//
//                            return controller
//                        }
//
//                        window.rootViewController = makeScreen()

        //экран profile
//        let moduleBuilder = ModuleBuilder()
//        let router = ProfileRouter(
//            navigationController: navigationController,
//            moduleBuilder: moduleBuilder
//        )
//        router.initialViewController()
//        window.rootViewController = navigationController

//        window.makeKeyAndVisible()
//        self.window = window
    }

}
