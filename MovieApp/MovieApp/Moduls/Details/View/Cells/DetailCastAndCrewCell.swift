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
    static let identifier = String(describing: DetailCastAndCrewCell.self)

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
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalToSuperview()
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            // Расчет предполагаемого размера основывается на содержимом
            let item = castAndCrewItems[indexPath.item]
            let approximateWidthOfName = item.name?.size(withAttributes: [
                .font: UIFont.montserratSemiBold(ofSize: 14) ?? .systemFont(ofSize: 14)
            ]).width ?? 0
            let approximateWidthOfProfession = item.profession?.size(withAttributes: [
                .font: UIFont.montserratSemiBold(ofSize: 14) ?? .systemFont(ofSize: 14)
            ]).width ?? 0
            
            // Выбираем максимальное значение из двух для установки ширины
            let maxWidth = max(approximateWidthOfName, approximateWidthOfProfession)
            // Добавляем отступы и размер аватара к ширине
            let totalWidth = maxWidth + LayoutConstants.avatarSize + CGFloat(LayoutConstants.textLeadingOffset * 2)
            
            // Возвращаем размер ячейки с учетом расчетной ширины и высоты коллекции
            return CGSize(width: totalWidth, height: collectionView.bounds.height)
        }
}

// MARK: - Constants
private enum Titles {
    #warning("это надо раскидать по другим местам")
    static let castAndCrewCell = "CastAndCrewItemCell"
}

// MARK: - LayoutConstants
private enum LayoutConstants {
    static let collectionLeadingOffset = 25
    static let collectionViewWidth: CGFloat = 250
    static let avatarSize: CGFloat = 40
        static let textLeadingOffset = 10
}

