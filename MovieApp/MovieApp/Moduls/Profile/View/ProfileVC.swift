import UIKit

final class ProfileVC: UIViewController {
    
    // MARK: - Private UI Properties
    private lazy var profileView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.customGrey.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    // MARK: - Private Methods
    private func setViews() {
        view.backgroundColor = UIColor.customBlack
        view.addSubviewsTamicOff(profileView)
    }
    
    private func setupConstraints() {
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(84)
        }
    }
    
    private func setupNavigationBar() {
        title = "Profile"
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.montserratSemiBold(ofSize: 16) ?? UIFont.systemFont(ofSize: 16)
        ]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
    }
}
