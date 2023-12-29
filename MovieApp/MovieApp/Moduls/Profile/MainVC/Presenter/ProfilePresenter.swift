import UIKit


// MARK: - ProfilePresenterProtocol
protocol ProfilePresenterProtocol {
    init(view: ProfileVCProtocol, storageManager: StorageManagerProtocol, router: ProfileRouterProtocol)
    func showUserInfo()
    func showEditProfileVC()
    func showPolicyVC()
    func showAboutUsVC()
    func showNotificationVC()
    func showLanguageVC()
}

// MARK: - ProfilePresenter
final class ProfilePresenter: ProfilePresenterProtocol {
    
    private unowned var view: ProfileVCProtocol
    private var router: ProfileRouterProtocol
    private let storageManager: StorageManagerProtocol
    
    init(
        view: ProfileVCProtocol,
        storageManager: StorageManagerProtocol,
        router: ProfileRouterProtocol
    ) {
        self.view = view
        self.router = router
        self.storageManager = storageManager
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
    
    func showLanguageVC() {
        router.showLanguageVC()
    }
}
