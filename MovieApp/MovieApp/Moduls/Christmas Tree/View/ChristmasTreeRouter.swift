import UIKit

final class ChristmasTreeRouter: BaseRouter {

    let navigationController: UINavigationController
    private let factory: AppFactory

    init(navigationController: UINavigationController, factory: AppFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func start() {
        navigationController.viewControllers = [factory.makeChristmasTreeVC()]
    }
}
