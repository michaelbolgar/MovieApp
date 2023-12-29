//
//  LanguageVC.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 28.12.2023.
//

import UIKit

final class LanguageVC: UIViewController {
    
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

        return tableView
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupNavigationBar()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setViews() {
        view.backgroundColor = .customBlack
        
        view.addSubview(mainView)
        
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(200)
        }
    }
    
    private func setupNavigationBar() {
        setNavigationBar(title: "Language")
        

    }
}
