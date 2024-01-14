//
//  AboutUsVC.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import UIKit

protocol AboutUsVCProtocol: AnyObject {
    func reloadData()
}

final class AboutUsVC: UICollectionViewController {
    
    // MARK: - Presenter
    var presenter: AboutUsPresenterProtocol!
    
    // MARK: - Init
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 150)
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupCollectionView()
        setupNavigationBar()
    }
    
    // MARK: - Private Methods
    private func setupCollectionView() {
        collectionView.register(
            DeveloperCell.self,
            forCellWithReuseIdentifier: DeveloperCell.reuseID
        )
        collectionView.register(
            HeaderCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell"
        )
        
        collectionView.register(
            FooterCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerCell"
        )
        collectionView.backgroundColor = .clear
    }
    
    // MARK: - UITableDiewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.developers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DeveloperCell.reuseID,
                for: indexPath
            ) as? DeveloperCell
        else {
            return UICollectionViewCell()
        }
        
        
        let developer = presenter.developers[indexPath.row]
        cell.configure(with: developer)
        
        return cell
    }
    
 
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AboutUsVC: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
             guard let header = collectionView.dequeueReusableSupplementaryView(
                 ofKind: kind,
                 withReuseIdentifier: "headerCell",
                 for: indexPath) as? HeaderCell else {
                     return UICollectionReusableView()
             }
             // Настройка header, если нужно
             return header
         } else if kind == UICollectionView.elementKindSectionFooter {
             guard let footer = collectionView.dequeueReusableSupplementaryView(
                 ofKind: kind,
                 withReuseIdentifier: "footerCell",
                 for: indexPath) as? FooterCell else {
                     return UICollectionReusableView()
             }
             // Настройка footer, если нужно
             return footer
         }
         return UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 80) 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100) // Высота по вашему усмотрению
    }
}

// MARK: - AboutUsVCProtocol
extension AboutUsVC: AboutUsVCProtocol {
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - Setup UI
extension AboutUsVC {
    private func setViews() {
        view.backgroundColor = .customBlack
    }
    
    private func setupNavigationBar() {
        setNavigationBar(title: "About Us")
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = .customBlack
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
