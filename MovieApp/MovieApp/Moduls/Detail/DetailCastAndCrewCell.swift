//
//  CastAndCrewViewCell.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 05.01.24.
//

import UIKit

class DetailCastAndCrewCell: UICollectionViewCell {
    
    typealias CastAndCrewCell = CollectionCell<DetailCastAndCrewView>

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionCell<DetailCastAndCrewView>.self, forCellWithReuseIdentifier: "CastAndCrewItemCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // Массив данных для горизонтальной коллекции
    var castAndCrewItems: [DetailCastAndCrewView.Model] = []
    
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
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(25)
        }
    }
    
    func configure(with castAndCrewItems: [DetailCastAndCrewView.Model]) {
            self.castAndCrewItems = castAndCrewItems
            collectionView.reloadData()
        }
}

    extension DetailCastAndCrewCell: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return castAndCrewItems.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastAndCrewItemCell", for: indexPath) as! CollectionCell<DetailCastAndCrewView>
            let item = castAndCrewItems[indexPath.item]
            cell.update(with: item)
            return cell
        }
    }

extension DetailCastAndCrewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Верните нужный размер для ячейки
        return CGSize(width: 180, height: collectionView.bounds.height)
    }
}

