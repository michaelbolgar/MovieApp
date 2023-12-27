import UIKit

protocol ProfileVCProtocol: AnyObject {
    func setUserInfo(with user: User)
}

final class ProfileVC: UIViewController {
    
    // MARK: - Presenter
    var presenter: ProfilePresenterProtocol!
    
    // MARK: - Private UI Properties
    private let userInfoView = UserInfoView()
    private let generalView = GeneralView()
    private let moreView = MoreView()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstraints()
        setupNavigationBar()
        setupEditButton()
        setupPoliciesButton()
        setupAboutUsButton()
        setupEditButton()
        presenter.showUserInfo()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Saved") , object: nil, queue: nil) { _ in
            self.presenter.showUserInfo()
        }
    }
    
    // MARK: - Private Methods
    private func setupEditButton() {
        userInfoView.editButtonTap = {
            self.presenter.showEditProfileVC()
        }
    }
    
    private func setupPoliciesButton() {
        moreView.onFirstSetttingTap = {
            self.presenter.showPolicyVC()
        }
    }
    
    private func setupAboutUsButton() {
        moreView.onSecondSetttingTap = {
            self.presenter.showAboutUsVC()
        }
    }
    
}

// MARK: - Setup UI
private extension ProfileVC {
    func setViews() {
        view.backgroundColor = .customBlack
        view.addSubview(userInfoView)
        view.addSubview(generalView)
        view.addSubview(moreView)
    }
    
    func setupConstraints() {
        userInfoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(88)
        }
        
        generalView.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(200)
        }
        
        moreView.snp.makeConstraints { make in
            make.top.equalTo(generalView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(200)
        }
    }
    
    func setupNavigationBar() {
        title = "Profile"
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.montserratSemiBold(ofSize: 16) ?? UIFont.systemFont(ofSize: 16),
        ]
        
        navBarAppearance.backgroundColor = .customBlack
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

// MARK: - ProfileVCProtocol
extension ProfileVC: ProfileVCProtocol {
    func setUserInfo(with user: User) {
        userInfoView.setViews(with: user)
    }
}

