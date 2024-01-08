//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import UIKit

// MARK: - DetailViewController

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
        cv.register(
            HeaderCell.self, 
            forCellWithReuseIdentifier: Titles.header
        )
        cv.register(
            TextCell.self,
            forCellWithReuseIdentifier: Titles.textCell
        )
        cv.register(
            DetailGalleryCell.self, 
            forCellWithReuseIdentifier: Titles.galleryCell
        )
        cv.register(
            SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, 
            withReuseIdentifier: Titles.reuseIdentifier
        )
        cv.register(
            DetailCastAndCrewCell.self,
            forCellWithReuseIdentifier: Titles.castAndCrew
        )
           cv.delegate = self
           cv.dataSource = self
           cv.backgroundColor = .clear
        cv.contentInsetAdjustmentBehavior = .never
           return cv
       }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.activate()
        layout()
    }
    
    // MARK: - Layout
    
    private func layout() {
        view.addSubview(collectionView)
        view.backgroundColor = UIColor.customDarkBlue
        
        if #available(iOS 11.0, *) {
            collectionView.contentInset = UIEdgeInsets(
                top: view.safeAreaInsets.top,
                left: 0, bottom: 0,
                right: 0
            )
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - UICollectionView+Extension

extension DetailViewController: UICollectionViewDelegate, 
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
            return 1
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
            switch items[indexPath.section] {
            case .header:
                return CGSize(
                    width: collectionView.bounds.width,
                    height: LayoutConstants.headerHeight
                )
            case .storyLine:
                return CGSize(
                    width: collectionView.bounds.width - LayoutConstants.storyLineWidthSubtraction,
                    height: LayoutConstants.storyLineHeight
                )
            case .castAndCrew:
                return CGSize(
                    width: collectionView.bounds.width,
                    height: LayoutConstants.castHeight
                )
            case .gallery:
                return CGSize(
                    width: collectionView.bounds.width,
                    height: LayoutConstants.galleryHeight
                )
            }
        }

        func collectionView(_ collectionView: UICollectionView, 
                            layout collectionViewLayout: UICollectionViewLayout,
                            referenceSizeForHeaderInSection section: Int) -> CGSize {
            switch items[section] {
            case .storyLine, .castAndCrew, .gallery:
                return CGSize(
                    width: collectionView.bounds.width,
                    height: LayoutConstants.sectionsHeight
                )
            default:
                return CGSize.zero
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, 
                            viewForSupplementaryElementOfKind kind: String,
                            at indexPath: IndexPath) -> UICollectionReusableView {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: Titles.reuseIdentifier,
                for: indexPath
            ) as? SectionHeaderView else {
                fatalError(Titles.fatalError)
            }

            let sectionType = items[indexPath.section]
            let title: String
            switch sectionType {
            case .header:
                title = Titles.movieDetail
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
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.section]
        
        switch item {
        case .storyLine(item: let item):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Titles.textCell,
                for: indexPath
            ) as! TextCell
            cell.update(with: item)
            return cell
        case .castAndCrew:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Titles.castAndCrew,
                for: indexPath
            ) as! DetailCastAndCrewCell
            if let castAndCrewItem = viewModel?.castAndCrew.map({
                DetailCastAndCrewView.Model(
                    imageURL: $0.imageURL,
                    name: $0.name,
                    profession: $0.profession
                )
            }) {
                cell.configure(with: castAndCrewItem)
            }
            return cell
        case .gallery:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Titles.galleryCell,
                for: indexPath
            ) as! DetailGalleryCell
            if let galleryItem = viewModel?.gallery.map({
                DetailGalleryView.Model(imageURL: $0.imageURL)
            }) {
                cell.configure(with: galleryItem)
            }
            return cell
        case .header(item: let item):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Titles.header,
                for: indexPath
            ) as! HeaderCell
            cell.update(with: item)
            return cell
        }
    }
}

// MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    func update(with model: ViewModel) {
        
        title = model.title
        self.viewModel = model
        
        self.likeBarButtonAction = model.likeBarButtonAction
        if model.likeBarButtonAction != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(named: Titles.heartImage), 
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
    
    // MARK: - Actions
    
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

// MARK: - DetailViewModel

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

// MARK: - Constants
private enum Titles {
    static let castAndCrew = "CastAndCrew"
    static let header = "headerCell"
    static let textCell = "textCell"
    static let galleryCell = "Gallery"
    static let movieDetail = "Movie Detail"
    static let storyLineTitle = "Story Line"
    static let castAndCrewTitle = "Cast and Crew"
    static let galeryTitle = "Gallery"
    static let reuseIdentifier = "section-header-reuse-identifier"
    static let fatalError = "Cannot create new header"
    static let heartImage = "heart.fill"
}

private enum LayoutConstants {
    static let headerHeight: CGFloat = 580
    static let storyLineWidthSubtraction: CGFloat = 50
    static let storyLineHeight: CGFloat = 150
    static let castHeight: CGFloat = 60
    static let galleryHeight: CGFloat = 180
    static let sectionsHeight: CGFloat = 40
}

