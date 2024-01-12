//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import UIKit
import FBSDKShareKit

// MARK: - DetailViewController

class DetailViewController: UIViewController {
  
    
    
    typealias HeaderCell = CollectionCell<DetailHeaderView>
    typealias TextCell = CollectionCell<UILabel>
    
    var presenter: DetailPresenterProtocol!
    
    private var items = [ViewModel.Item]()
    private var likeBarButtonAction: (() -> Void)?
    private var viewModel: ViewModel?
    private var shareView: ShareView?
    private var blurEffectView: UIVisualEffectView?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
#warning("заменить reuseIdentifier на нетекстовое значение для всех пяти ячеек -- спроси Мишу как")
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
            forCellWithReuseIdentifier: DetailGalleryCell.identifier
        )
        cv.register(
            SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Titles.reuseIdentifier
        )
        cv.register(
            DetailCastAndCrewCell.self,
            forCellWithReuseIdentifier: DetailCastAndCrewCell.identifier
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
        setupShareView()
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
    private func setupShareView() {
        shareView = ShareView()
        shareView?.parentViewController = self
        shareView?.alpha = 0
        shareView?.closeButton.addTarget(self, action: #selector(hideShareView), for: .touchUpInside)
//        shareView?.instagramButton.addTarget(self, action: #selector(facebookShareButtonTapped), for: .touchUpInside)
        view.addSubview(shareView!)
        shareView?.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(200)
        }
    }
    
    internal func blurBackground() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
//    @objc private func facebookShareButtonTapped() {
//        guard let url = URL(string: "https://developers.facebook.com") else {
//            // handle and return
//        }
//
//        let content = ShareLinkContent()
//        content.contentURL = url
//
//        let dialog = ShareDialog(
//            viewController: self,
//            content: content,
//            delegate: self
//        )
//        dialog.show()
//        }
    
    @objc func hideShareView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.shareView?.alpha = 0
        }) { _ in
            self.blurEffectView?.removeFromSuperview()
        }
    }
    
    @objc func fBTapped() {
        print("fB tapped")
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo
        info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let image = info[.originalImage] as? UIImage else {
            // handle and return
            return
        }
        let photo = SharePhoto(
            image: image,
            isUserGenerated: true
        )
        var content = SharePhotoContent()
        content.photos = [photo]
        // use the content
        var button = FBShareButton()
        button.shareContent = content
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
            fatalError("Cannot create new header")
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
                withReuseIdentifier: DetailCastAndCrewCell.identifier,
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
                withReuseIdentifier: DetailGalleryCell.identifier,
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
    func showShareView() {
        setupBlurView()
        UIView.animate(withDuration: 0.3) {
            self.shareView?.alpha = 1
        }
    }
    
    private func setupBlurView() {
        blurEffectView?.removeFromSuperview() // Удаляем предыдущее размытие, если оно было добавлено
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView!)
        
        // Убедимся, что shareView добавляется поверх blurEffectView
        view.addSubview(shareView!)
        view.bringSubviewToFront(shareView!)
    }
    
    func update(with model: ViewModel) {
        
        DispatchQueue.main.async {
            self.title = model.title
            if model.likeBarButtonAction != nil {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    image: UIImage(named: "heart.fill"),
                    style: .plain,
                    target: self,
                    action: #selector(self.didTapLikeBarButton))
            } else {
                self.navigationItem.rightBarButtonItem = nil
            }
            
            self.viewModel = model
            
            self.likeBarButtonAction = model.likeBarButtonAction
            
            
            self.items.removeAll()
            
            self.items.append(
                .header(
                    item: .init(
                        imageURL: model.header.imageURL,
                        duration: model.header.duration,
                        genre: model.header.genre,
                        rating: model.header.rating,
                        year: model.header.year,
                        trailerClosure: model.header.trailerClosure,
                        shareClosure: model.header.shareClosure)))
            self.items.append(
                .storyLine(
                    item: .init(text: model.storyLine)))
            self.items.append(.castAndCrew)
            self.items.append(.gallery)
            
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Actions
    
    func showLoading() {
        print("show lodaing")
        collectionView.isHidden = true
    }
    
    func hideLoading() {
        print("hide lodaing")
        collectionView.isHidden = false
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
            let duration: Int?
            let genre: String?
            let rating: Double?
            let year: Int?
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
#warning("тут надо пройтись по комментам и всё поправить")
    //эти мы уберём вообще
    
    static let header = "headerCell"
    static let textCell = "textCell"
    
    static let reuseIdentifier = "section-header-reuse-identifier"
    
    //эти норм
    static let movieDetail = "Movie Detail"
    static let storyLineTitle = "Story Line"
    //за наименования castAndCrewTitle и castAndCrew в енаме 'Titles' тебя надо отдать под суд :D это исправится само
    static let castAndCrewTitle = "Cast and Crew"
    static let galeryTitle = "Gallery"
}

private enum LayoutConstants {
    static let headerHeight: CGFloat = 580
    static let storyLineWidthSubtraction: CGFloat = 50
    static let storyLineHeight: CGFloat = 150
    static let castHeight: CGFloat = 60
    static let galleryHeight: CGFloat = 180
    static let sectionsHeight: CGFloat = 40
}
