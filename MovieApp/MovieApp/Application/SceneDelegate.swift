import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

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
    }

}
