import UIKit

final class ProfileVC: UIViewController {
    
    // MARK: - Profile View
    private lazy var profileView: UIView = {
        var view = makeView()
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        var label = UILabel.makeLabel(
            text: "Kirill",
            font: UIFont.montserratSemiBold(ofSize: 16),
            textColor: .white,
            numberOfLines: 1
        )
        return label
    }()
    
    private lazy var userEmailLabel: UILabel = {
        var label = UILabel.makeLabel(
            text: "taraturin.kirill.dev@gmail.com",
            font: UIFont.montserratMedium(ofSize: 14),
            textColor: UIColor.lightGray,
            numberOfLines: 1
        )
        return label
    }()
    
    private lazy var editButton: UIButton = {
        var button = UIButton()
        let editImage = UIImage(named: "editButton")
        button.setImage(editImage, for: .normal)
        return button
    }()
    
    // MARK: - General View
    private lazy var generalView: UIView = {
        var view = makeView()
        return view
    }()
    
    // MARK: - More View
    private lazy var moreView: UIView = {
        var view = makeView()
        return view
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstraints()
        setupNavigationBar()
    }
}

// MARK: - Setup UI
private extension ProfileVC {
    func setViews() {
        view.backgroundColor = UIColor.customBlack
        view.addSubviewsTamicOff(profileView,
                                 generalView,
                                 moreView
        )
        profileView.addSubviewsTamicOff(profileImageView,
                                        userNameLabel,
                                        userEmailLabel,
                                        editButton
        )
    }
    
    func setupConstraints() {
        
        // profileView Constraints
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(84)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(50)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.left.equalTo(profileImageView.snp.right).offset(16)
        }
        
        userEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(8)
            make.left.equalTo(profileImageView.snp.right).offset(16)
            make.right.equalTo(editButton.snp.left).offset(-18)
        }
        
        editButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-19)
            make.top.equalToSuperview().offset(31)
            make.bottom.equalToSuperview().offset(-31)
            make.width.equalTo(24)
        }
        
        // generalView Constraints
        generalView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(38)
            make.right.equalToSuperview().offset(-38)
            make.height.equalTo(196)
        }
        
        // moreView Constraints
        moreView.snp.makeConstraints { make in
            make.top.equalTo(generalView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(38)
            make.right.equalToSuperview().offset(-38)
            make.height.equalTo(180)
        }
    }
    
    func setupNavigationBar() {
        title = "Profile"
        let navBarAppearance = UINavigationBarAppearance()

        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.montserratSemiBold(ofSize: 16) ?? UIFont.systemFont(ofSize: 16)
        ]

        navigationController?.navigationBar.standardAppearance = navBarAppearance
    }
    
    // MARK: - Make UI Methods
    func makeView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.customGrey.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 15
        return view
    }
}
