//
//  CastAndCrewViewCell.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 05.01.24.
//

import UIKit

// MARK: - DetailCastAndCrewCell
class DetailCastAndCrewCell: UICollectionViewCell {
    
    typealias CastAndCrewCell = CollectionCell<DetailCastAndCrewView>
    
    // MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            CollectionCell<DetailCastAndCrewView>.self,
            forCellWithReuseIdentifier: Titles.castAndCrewCell
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    // Массив данных для горизонтальной коллекции
    var castAndCrewItems: [DetailCastAndCrewView.Model] = []
    
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
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(
                LayoutConstants.collectionLeadingOffset
            )
        }
    }
    
    // MARK: - Configure
    func configure(with castAndCrewItems: [DetailCastAndCrewView.Model]) {
        self.castAndCrewItems = castAndCrewItems
        collectionView.reloadData()
    }
}

// MARK: - DetailCastAndCrewCell+Extension
extension DetailCastAndCrewCell: UICollectionViewDelegate, 
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return castAndCrewItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Titles.castAndCrewCell,
            for: indexPath
        ) as! CollectionCell<DetailCastAndCrewView>
        let item = castAndCrewItems[indexPath.item]
        cell.update(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: LayoutConstants.collectionViewWidth,
                      height: collectionView.bounds.height)
    }
}

// MARK: - Constants
private enum Titles {
    #warning("это надо раскидать по другим местам")
    static let fatalError = "init(coder:) has not been implemented"
    static let castAndCrewCell = "CastAndCrewItemCell"
}

// MARK: - LayoutConstants
private enum LayoutConstants {
    static let collectionLeadingOffset = 25
    static let collectionViewWidth: CGFloat = 180
}


