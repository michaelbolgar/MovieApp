//
//  DetailGalleryCell.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 05.01.24.
//

import UIKit

// MARK: - Constants
private enum Titles {
#warning("см. комментарии к Titles в DetailHeaderView")
    static let fatalError = "init(coder:) has not been implemented"
    static let galleryCell = "GalleryItemCell"
    static let width: CGFloat = 100
}

// MARK: - DetailGalleryCell
class DetailGalleryCell: UICollectionViewCell {
    
    typealias GalleryCell = CollectionCell<DetailGalleryView>
    
    // MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            GalleryCell.self,
            forCellWithReuseIdentifier: Titles.galleryCell
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // Массив данных для горизонтальной коллекции
    var galleryItems: [DetailGalleryView.Model] = []
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Titles.fatalError)
    }
    
    // MARK: - Layout
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    func configure(with galleryItems: [DetailGalleryView.Model]) {
        self.galleryItems = galleryItems
        collectionView.reloadData()
    }
}

// MARK: - DetailGalleryCell+Extension
extension DetailGalleryCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return galleryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Titles.galleryCell,
            for: indexPath) as! GalleryCell
        let item = galleryItems[indexPath.item]
        cell.update(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Titles.width, height: collectionView.bounds.height)
    }
}




