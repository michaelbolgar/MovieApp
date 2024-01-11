//import UIKit
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//    
//    var window: UIWindow?
//    let factory: AppFactory = Factory()
//    
//#warning("убрать force unwrap")
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        window = UIWindow(windowScene: windowScene)
//        let rootRouter = factory.makeRootRouter(window!)
//        rootRouter.start()
//        
//        let window = UIWindow(windowScene: windowScene)
////        detailsRequest()
//        
//        // Define the detailsRequest function
//       
//            DispatchQueue.main.async {
//                self.window?.rootViewController = makeScreen(with: 666)
//                self.window?.makeKeyAndVisible()
//            }
//        
//        
//        
//        // Define the makeScreen function
//        func makeScreen(with movieId: Int) -> UIViewController {
//            let controller = DetailViewController()
//            let presenter = DetailPresenter(movieId: movieId)
//            
//            controller.presenter = presenter
//            presenter.view = controller
//            
//            return controller
//        }
//        
//        self.window = window
//        //три разных экрана
//        //        window.rootViewController = UINavigationController(rootViewController: ViewController())
//        //        window.rootViewController = MainTabBarController()
//        //        let navigationController = UINavigationController()
//        
//        //экран details
//        //        func makeScreen() -> UIViewController {
//        //                            let controller = DetailViewController()
//        //                            let presenter = DetailPresenter()
//        //
//        //                            controller.presenter = presenter
//        //                            presenter.view = controller
//        //
//        //                            return controller
//        //                        }
//        //
//        //                        window.rootViewController = makeScreen()
//        
//        //экран profile
//        //        let moduleBuilder = ModuleBuilder()
//        //        let router = ProfileRouter(
//        //            navigationController: navigationController,
//        //            moduleBuilder: moduleBuilder
//        //        )
//        //        router.initialViewController()
//        //        window.rootViewController = navigationController
//        
//        //        window.makeKeyAndVisible()
//        //        self.window = window
//    }
//
//}

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let factory: AppFactory = Factory()

#warning("убрать force unwrap")
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
//        let rootRouter = factory.makeRootRouter(window!)
//        rootRouter.start()
        let controller = MovieListController()
        let MovieListModel = MovieListModel()
        let presenter = MovieListPresenterImpl(model: MovieListModel)
        presenter.view = controller
        window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
    }
}
