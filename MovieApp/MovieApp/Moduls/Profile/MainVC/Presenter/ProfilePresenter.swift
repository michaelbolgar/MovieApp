import UIKit


// MARK: - ProfilePresenterProtocol
protocol ProfilePresenterProtocol {
    init(view: ProfileVCProtocol, router: ProfileRouterProtocol)
    func showUserInfo()
    func showEditProfileVC()
    func showPolicyVC()
    func showAboutUsVC()
    func showNotificationVC()
}

// MARK: - ProfilePresenter
final class ProfilePresenter: ProfilePresenterProtocol {

    private unowned var view: ProfileVCProtocol
    private var router: ProfileRouterProtocol
    private let storageManager = StorageManager.shared
    
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
    
    func showUserInfo(){
        if let user = storageManager.fetchUser() {
            view.setUserInfo(with: user)
        }
    }
    
    func showNotificationVC() {
        router.showNotificationVC()
    }
}
