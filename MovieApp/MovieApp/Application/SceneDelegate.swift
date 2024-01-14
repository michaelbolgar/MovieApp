import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let factory: AppFactory = Factory()

#warning("force unwrap тут допустим?")
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let rootRouter = factory.makeRootRouter(window!)
        rootRouter.start()
//        getUpcoming()
    }

//    private func getUpcoming() {
//        NetworkingManager.shared.getUpcoming { result in
//            switch result {
//            case .success(let upcomingMovies):
//                print("Upcoming movies: \(upcomingMovies)")
//            case .failure(let error):
//                print("Error fetching upcoming movies: \(error)")
//            }
//        }
//    }
}
