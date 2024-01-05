//
//  DetailGalleryCell.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 05.01.24.
//

import UIKit

class DetailGalleryCell: UICollectionViewCell {
    
    typealias GalleryCell = CollectionCell<DetailGalleryView>

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: "GalleryItemCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // Массив данных для горизонтальной коллекции
    var galleryItems: [DetailGalleryView.Model] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with galleryItems: [DetailGalleryView.Model]) {
            self.galleryItems = galleryItems
            collectionView.reloadData()
        }
}

    extension DetailGalleryCell: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return galleryItems.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCell", for: indexPath) as! GalleryCell
            let item = galleryItems[indexPath.item]
            cell.update(with: item)
            return cell
        }
    }

extension DetailGalleryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Верните нужный размер для ячейки
        return CGSize(width: 100, height: collectionView.bounds.height)
    }
}




