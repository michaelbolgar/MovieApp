import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func setUserInfo(with user: User)
}

final class HomeViewController: UIViewController {
    
    //MARK: - Presenter
    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    func setViews(){
        
    }
}
