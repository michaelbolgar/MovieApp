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
        setupNotificationButton()
        setupLanguageViewButton()
        presenter.showUserInfo()
        addObserver()
    }
    
    // MARK: - Private Methods
    private func setupEditButton() {
        userInfoView.editButtonTap = {
            self.presenter.showEditProfileVC()
        }
    }
    
    private func setupNotificationButton() {
        generalView.onFirstSetttingTap = {
            self.presenter.showNotificationVC()
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
    
    private func setupLanguageViewButton() {
        generalView.onSecondSetttingTap = {
            self.presenter.showLanguageVC()
        }
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name("Saved"),
            object: nil, queue: nil) { _ in
                self.presenter.showUserInfo()
            }
    }
}

// MARK: - ProfileVCProtocol
extension ProfileVC: ProfileVCProtocol {
    func setUserInfo(with user: User) {
        userInfoView.setViews(with: user)
    }
}

// MARK: - Setup UI
private extension ProfileVC {
    func setViews() {
        view.backgroundColor = .customBlack
        [userInfoView, generalView, moreView].forEach { view.addSubview($0) }
    }
    
    func setupConstraints() {
        userInfoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(LayoutConstants.topOffset)
            make.left.equalToSuperview()
                .offset(LayoutConstants.leftRightOffset)
            make.right.equalToSuperview()
                .offset(-LayoutConstants.leftRightOffset)
            make.height.equalTo(LayoutConstants.elementHeight)
        }
        
        generalView.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.bottom)
                .offset(LayoutConstants.verticalSpacing)
            make.left.equalToSuperview()
                .offset(LayoutConstants.leftRightOffset)
            make.right.equalToSuperview()
                .offset(-LayoutConstants.leftRightOffset)
            make.height.equalTo(LayoutConstants.generalHeight)
        }
        
        moreView.snp.makeConstraints { make in
            make.top.equalTo(generalView.snp.bottom)
                .offset(LayoutConstants.verticalSpacing)
            make.left.equalToSuperview()
                .offset(LayoutConstants.leftRightOffset)
            make.right.equalToSuperview()
                .offset(-LayoutConstants.leftRightOffset)
            make.height.equalTo(LayoutConstants.moreHeight)
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
    
    enum LayoutConstants {
        static let topOffset = 24
        static let leftRightOffset = 24
        static let elementHeight = 88
        static let generalHeight = 200
        static let moreHeight = 200
        static let verticalSpacing = 20
    }
}
