//
//  LanguageVC.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 28.12.2023.
//

import UIKit

protocol LanguageVCProtocol: AnyObject {
}

final class LanguageVC: UIViewController {
    
    // MARK: - Presenter
    var presenter: LanguagePresenterProtocol!
    
    // MARK: - Private UI Properties
    private var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.customGrey.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private var tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = .clear
        tableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseID)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        return tableView
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setNavigationBar(title: "Language")
        setupConstraints()
        setupTableView()
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setViews() {
        view.backgroundColor = .customBlack
        view.addSubview(mainView)
        mainView.addSubview(tableView)
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(LayoutConstraint.mainViewTopOffset)
            make.leading.trailing.equalToSuperview()
                .inset(LayoutConstraint.mainViewHorizontalOffset)
            make.height.equalTo(LayoutConstraint.mainViewHeight)
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private enum LayoutConstraint {
        static let mainViewTopOffset: CGFloat = 20
        static let mainViewHorizontalOffset: CGFloat = 25
        static let mainViewHeight: CGFloat = 160
    }
}

// MARK: - UITableViewDataSource
extension LanguageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: LanguageCell.reuseID,
                for: indexPath) as? LanguageCell
        else {
            return UITableViewCell()
        }
        let language = presenter.languages[indexPath.row]
        let checkValue = (indexPath == presenter.lastSelectedIndexPath)
        cell.configure(with: language)
        cell.setCheckmarkValue(checkValue)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LanguageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let label = UILabel.makeLabel(
            text: "Available Languages",
            font: .montserratMedium(ofSize: 15),
            textColor: .customDarkGrey,
            numberOfLines: 1
        )
        
        headerView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let lastIndexPath = presenter.lastSelectedIndexPath,
           let lastCell = tableView.cellForRow(at: lastIndexPath) as? LanguageCell {
            lastCell.setCheckmarkValue(false)
        }
        
        presenter.lastSelectedIndexPath = indexPath
        if let cell = tableView.cellForRow(at: indexPath) as? LanguageCell {
            cell.setCheckmarkValue(true)
        }
    }
}

// MARK: - LanguageVCProtocol
extension LanguageVC: LanguageVCProtocol {
}
