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
    }
}


//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    var window: UIWindow?
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = ViewController()
//        window.makeKeyAndVisible()
//        self.window = window
//    }
//}

