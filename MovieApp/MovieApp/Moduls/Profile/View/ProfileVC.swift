import UIKit

final class ProfileVC: UIViewController {
    
    // MARK: - Private Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.reuseID)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .customBlack
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setViews()
        setupConstraints()
        setupNavigationBar()
    }
}

// MARK: - Setup UI
private extension ProfileVC {
    func setViews() {
        view.backgroundColor = .customBlack
        view.addSubview(tableView)
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
