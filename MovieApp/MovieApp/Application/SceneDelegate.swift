import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let factory: AppFactory = Factory()

    //TODO: убрать force unwrap
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let rootRouter = factory.makeRootRouter(window!)
        rootRouter.start()

//        window.rootViewController = MainTabBarController()

//        let navigationController = UINavigationController()
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
