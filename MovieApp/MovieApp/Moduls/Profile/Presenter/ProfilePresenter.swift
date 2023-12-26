import UIKit


// MARK: - ProfilePresenterProtocol
protocol ProfilePresenterProtocol {
    init(view: ProfileVCProtocol)
}

// MARK: - ProfilePresenter
final class ProfilePresenter: ProfilePresenterProtocol {
    
    private unowned var view: ProfileVCProtocol
    
    init(view: ProfileVCProtocol) {
        self.view = view
    }

}
