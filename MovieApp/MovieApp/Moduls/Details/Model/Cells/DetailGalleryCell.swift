//
//  DetailGalleryCell.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 05.01.24.
//

import UIKit

// MARK: - DetailGalleryCell
class DetailGalleryCell: UICollectionViewCell {

    typealias GalleryCell = DetailCell<DetailGalleryView>
    static let identifier = String(describing: DetailGalleryCell.self)

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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: Layout.sectionInset, bottom: 0, right: 0) // Установка отступа секции
        layout.minimumLineSpacing = Layout.itemSpacing // Установка промежутка между элементами
        collectionView.setCollectionViewLayout(layout, animated: true)
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

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Titles.galleryCell, for: indexPath) as! GalleryCell
        let item = galleryItems[indexPath.item]
        cell.update(with: item)
        cell.clipsToBounds = true

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Layout.cellSize, height: Layout.cellSize)
    }
}

// MARK: - Titles Enum
private enum Titles {
    static let fatalError = "init(coder:) has not been implemented"
    static let galleryCell = "GalleryItemCell"
}

// MARK: - CGFloat Private Extension
private enum Layout {
    static let cellSize: CGFloat = 120
    static let sectionInset: CGFloat = 25
    static let itemSpacing: CGFloat = 20
}
