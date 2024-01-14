import UIKit

final class RootRouter {
    private let window: UIWindow?
    private let factory: AppFactory

    init(
        window: UIWindow?,
        factory: AppFactory
    ) {
        self.window = window
        self.factory = factory
    }

    func start() {

        //insert here code for dark/light mode if needed

        window?.rootViewController = showMainTabbar()
        window?.makeKeyAndVisible()
    }

    func showMainTabbar() -> UITabBarController {
        return factory.makeTabBar(
            factory.makeHomeRouter().navigationController ?? UINavigationController(),
            factory.makeSearchRouter().navigationController ?? UINavigationController(),
            factory.makeChristmasTreeRouter().navigationController,
            factory.makeProfileRouter().navigationController!
        )
    }
}
