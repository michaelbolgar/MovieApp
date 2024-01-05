//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import UIKit

private enum Titles {
    static let castAndCrew = "CastAndCrew"
    static let header = "headerCell"
    static let textCell = "textCell"
    static let galleryCell = "Gallery"
    static let storyLineTitle = "Story Line"
    static let castAndCrewTitle = "Cast and Crew"
    static let galeryTitle = "Gallery"
}

class DetailViewController: UIViewController {
    
    typealias HeaderCell = CollectionCell<DetailHeaderView>
    typealias TextCell = CollectionCell<UILabel>
    
    var presenter: DetailPresenterProtocol!
    
    private var items = [ViewModel.Item]()
    private var likeBarButtonAction: (() -> Void)?
    private var viewModel: ViewModel?
    
    private lazy var collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(HeaderCell.self, forCellWithReuseIdentifier: Titles.header)
        cv.register(TextCell.self, forCellWithReuseIdentifier: Titles.textCell)
        cv.register(DetailGalleryCell.self, forCellWithReuseIdentifier: Titles.galleryCell)
        cv.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        cv.register(DetailCastAndCrewCell.self, forCellWithReuseIdentifier: Titles.castAndCrew)
           cv.delegate = self
           cv.dataSource = self
           cv.backgroundColor = .clear
        cv.contentInsetAdjustmentBehavior = .automatic
           return cv
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        presenter.activate()
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(self.view.snp.top)
        }
        view.backgroundColor = UIColor.customDarkBlue
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
            collectionView.contentInset = UIEdgeInsets(top: view.safeAreaInsets.top, left: 0, bottom: 0, right: 0)
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            switch items[indexPath.section] {
            case .header:
                return CGSize(width: collectionView.bounds.width, height: 580) // Исправьте высоту на необходимую для вашего дизайна
            case .storyLine:
                return CGSize(width: collectionView.bounds.width - 50, height: 150) // Исправьте высоту на необходимую для вашего дизайна
            case .castAndCrew:
                return CGSize(width: collectionView.bounds.width, height: 60) // Исправьте высоту на необходимую для вашего дизайна
            case .gallery:
                return CGSize(width: collectionView.bounds.width, height: 180) // Исправьте высоту на необходимую для вашего дизайна
            }
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            switch items[section] {
            case .storyLine, .castAndCrew, .gallery:
                return CGSize(width: collectionView.bounds.width, height: 40)
            default:
                return CGSize.zero
            }
        }
        
        // Убедитесь, что метод viewForSupplementaryElementOfKind находится вне sizeForItemAt
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as? SectionHeaderView else {
                fatalError("Cannot create new header")
            }

            let sectionType = items[indexPath.section]
            let title: String
            switch sectionType {
            case .header:
                title = "Movie Detail"
            case .storyLine:
                title = Titles.storyLineTitle
            case .castAndCrew:
                title = Titles.castAndCrewTitle
            case .gallery:
                title = Titles.galeryTitle
            }

            headerView.configure(with: title)
            return headerView
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.section]
        
        switch item {
        case .storyLine(item: let item):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Titles.textCell, for: indexPath) as! TextCell
            cell.update(with: item)
            return cell
        case .castAndCrew:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Titles.castAndCrew, for: indexPath) as! DetailCastAndCrewCell
            if let castAndCrewItem = viewModel?.castAndCrew.map({
                DetailCastAndCrewView.Model(imageURL: $0.imageURL, name: $0.name, profession: $0.profession)
            }) {
                cell.configure(with: castAndCrewItem)
            }
            return cell
        case .gallery:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Titles.galleryCell, for: indexPath) as! DetailGalleryCell
            if let galleryItem = viewModel?.gallery.map({
                DetailGalleryView.Model(imageURL: $0.imageURL)
            }) {
                cell.configure(with: galleryItem)
            }
            return cell
        case .header(item: let item):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Titles.header, for: indexPath) as! HeaderCell
            cell.update(with: item)
            return cell
        }
    }
}

extension DetailViewController: DetailViewProtocol {
    func update(with model: ViewModel) {
        
        title = model.title
        self.viewModel = model
        
        self.likeBarButtonAction = model.likeBarButtonAction
        if model.likeBarButtonAction != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(named: "heart.fill"), 
                style: .plain,
                target: self,
                action: #selector(didTapLikeBarButton))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
        
        items.removeAll()
        
        items.append(
            .header(
                item: .init(
                    imageURL: model.header.imageURL,
                    duration: model.header.duration,
                    genre: model.header.genre,
                    rating: model.header.rating,
                    year: model.header.year,
                    trailerClosure: model.header.trailerClosure,
                    shareClosure: model.header.shareClosure)))
        items.append(
            .storyLine(
                item: .init(text: model.storyLine)))
        items.append(.castAndCrew)
        items.append(.gallery)
        
        collectionView.reloadData()
    }
    
    func showLoading() {
        print("show lodaing")
    }
    
    func hideLoading() {
        print("hide lodaing")
    }
    
    @objc
    private func didTapLikeBarButton() {
        likeBarButtonAction?()
    }
}

extension DetailViewController {
    struct ViewModel {
        
        struct HeaderItem {
//            let imageURL: URL?
            let imageURL: String?
            let duration: String?
            let genre: String?
            let rating: String?
            let year: String?
            let trailerClosure: (() -> Void)
            let shareClosure: (() -> Void)
        }
        
        struct CastAndCrewItem {
//            let imageURL: URL?
            let imageURL: String?
            let name: String?
            let profession: String?
        }
        
        struct GalleryItem {
//            let imageURL: URL?
            let imageURL: String?
        }
        
        enum Item {
            case header(item: DetailHeaderView.Model)
            case storyLine(item: UILabel.Model)
            case castAndCrew
            case gallery
        }
        
        let title: String
        let storyLine: String
        let header: HeaderItem
        let castAndCrew: [CastAndCrewItem]
        let gallery: [GalleryItem]
        let likeBarButtonAction: (() -> Void)?
    }
}

