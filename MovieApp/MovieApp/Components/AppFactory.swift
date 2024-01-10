import UIKit

protocol BaseRouter: AnyObject {
    var navigationController: UINavigationController { get }
    func start()
    func back()
    func popToRoot()
}

extension BaseRouter {
    func back() {
        navigationController.popViewController(animated: true)
    }

    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}

protocol AppFactory: AnyObject {

    func makeRootRouter(_ window: UIWindow) -> RootRouter
    func makeTabBar(_ viewControllers: UIViewController...) -> UITabBarController

    func makeHomeViewController() -> UIViewController
    func makeSearchViewController() -> UIViewController
    func makeChristmasTreeVC() -> UIViewController
    func makeProfileViewController() -> UIViewController

    func makeHomeRouter() -> BaseRouter
    func makeSearchRouter() -> BaseRouter
    func makeChristmasTreeRouter() -> BaseRouter
    func makeProfileRouter() -> ProfileRouter
}

final class Factory: AppFactory {

    func makeRootRouter(_ window: UIWindow) -> RootRouter {
        RootRouter(window: window, factory: self)
    }

    func makeTabBar(_ viewControllers: UIViewController...) -> UITabBarController {
        let tabbar = MainTabBarController()
        tabbar.viewControllers = viewControllers
        return tabbar
    }

    //MARK: - Creating ViewControllers
    func makeHomeViewController() -> UIViewController {
        HomeViewController()
    }

    func makeSearchViewController() -> UIViewController {
        SearchVC()
    }

    func makeChristmasTreeVC() -> UIViewController {
        ChristmasTreeVC()
    }

    func makeProfileViewController() -> UIViewController {
        ProfileVC()
    }

    //MARK: - Crating Routers
    func makeHomeRouter() -> BaseRouter {
        let navController = UINavigationController()
        navController.configureTabBarItem(
            "Home",
            image: "house.fill"
        )
        let router = HomeRouter(navigationController: navController, factory: self)
        router.start()
        return router
    }

    func makeSearchRouter() -> BaseRouter {
        let navController = UINavigationController()
        navController.configureTabBarItem(
            "Search",
            image: "magnifyingglass"
        )
        let router = SearchRouter(navigationController: navController, factory: self)
        router.start()
        return router
    }

    func makeChristmasTreeRouter() -> BaseRouter {
        let navController = UINavigationController()
        navController.configureTabBarItem(
            "Tree",
            image: "puzzlepiece.extension.fill"
        )
        let router = ChristmasTreeRouter(navigationController: navController, factory: self)
        router.start()
        return router
    }

    #warning("подвести под BaseRouter: затык с опциональным UINavigationController")
    func makeProfileRouter() -> ProfileRouter {
        let navController = UINavigationController()
        navController.configureTabBarItem(
            "Profile",
            image: "person.fill"
        )
        let moduleBuilder = ModuleBuilder()
        let router = ProfileRouter(navigationController: navController, moduleBuilder: moduleBuilder)
        router.initialViewController()
        return router
    }
}
