import UIKit


// MARK: - ProfilePresenterProtocol
protocol ProfilePresenterProtocol {
    init(view: ProfileVCProtocol, router: ProfileRouterProtocol)
    func showEditProfileVC()
    func showPolicyVC()
    func showAboutUsVC()
}

// MARK: - ProfilePresenter
final class ProfilePresenter: ProfilePresenterProtocol {

    private unowned var view: ProfileVCProtocol
    private var router: ProfileRouterProtocol
    
    init(view: ProfileVCProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func showEditProfileVC() {
        router.showEditProfileVC()
    }
    
    func showPolicyVC() {
        router.showPolicyVC()
    }
    
    func showAboutUsVC() {
        router.showAboutUsVC()
    }
}
