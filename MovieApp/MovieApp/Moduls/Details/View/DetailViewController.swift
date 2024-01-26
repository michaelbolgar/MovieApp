//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import UIKit
import WebKit

// MARK: - DetailViewController

final class DetailViewController: UIViewController {

    typealias HeaderCell = DetailCell<DetailHeaderView>
    
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
        cv.register(
            HeaderCell.self,
            forCellWithReuseIdentifier: Titles.headerCell
        )
        cv.register(
            DetailStoryLineCell.self,
            forCellWithReuseIdentifier: DetailStoryLineCell.identifier
        )
        cv.register(
            DetailGalleryCell.self,
            forCellWithReuseIdentifier: DetailGalleryCell.identifier
        )
        cv.register(
            SectionHeaderView.self, 
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
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
        setNavigationBar(title: "")
        presenter.activate()
        layout()
        setupShareView()
        collectionView.delegate = self
    }
    
    // MARK: - Layout
    
    private func layout() {
        view.addSubview(collectionView)
        view.backgroundColor = UIColor.customDarkBlue
        
        if #available(iOS 11.0, *) {
            let topInset = view.safeAreaInsets.top - 40
            collectionView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
            collectionView.scrollIndicatorInsets = collectionView.contentInset
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    private func setupShareView() {
        shareView = ShareView()
        shareView?.alpha = 0
        shareView?.onInstagramShare = { [weak self] in
            self?.presenter.shareToInstagram()
        }
        shareView?.onTwitterShare = { [weak self] in
            self?.presenter.shareToTwitter()
        }
        shareView?.onMessengerShare = { [weak self] in
            self?.presenter.shareToMessenger()
        }
        shareView?.onFacebookShare = { [weak self] in
            self?.presenter.shareToFacebook()
        }
        shareView?.onCloseTapped = { [weak self] in
            self?.presenter.closeShareView()
        }
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
        case .storyLine(let storyLineItem):
            let width = collectionView.bounds.width - LayoutConstants.storyLineWidthSubtraction
            let font = UIFont.montserratSemiBold(ofSize: 15) ?? .italicSystemFont(ofSize: 15)
            let textHeight = heightForText(
                storyLineItem.text,
                width: width,
                font: font
            )
            let expandedHeight = textHeight + (40) // отступы
            return CGSize(
                width: width,
                height: storyLineItem.isExpanded ?
                expandedHeight : LayoutConstants.storyLineHeight
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
    
    private func heightForText(_ text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let nsstring = NSString(string: text)
        let maxHeight = CGFloat.greatestFiniteMagnitude
        let textAttributes = [NSAttributedString.Key.font: font]
        let boundingRect = nsstring.boundingRect(with: CGSize(width: width, height: maxHeight),
                                                 options: .usesLineFragmentOrigin,
                                                 attributes: textAttributes,
                                                 context: nil)
        return ceil(boundingRect.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch items[section] {
        case .castAndCrew, .gallery:
            return CGSize(
                width: collectionView.bounds.width,
                height: LayoutConstants.sectionsHeight
            )
        case .storyLine:
            return CGSize(width: collectionView.bounds.width, height: 70)
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
        switch sectionType {
        case .header:
            headerView.configure(with: Titles.movieDetail)
        case .storyLine:
            headerView.configure(with: Titles.storyLineHeader, hasTopPadding: true)
        case .castAndCrew:
            headerView.configure(with: Titles.castAndCrewHeader)
        case .gallery:
            headerView.configure(with: Titles.galeryHeader)
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.section]
        
        switch item {
        case .storyLine(let storyLineItem):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DetailStoryLineCell.identifier,
                for: indexPath
            ) as! DetailStoryLineCell
            cell.configure(with: storyLineItem.text, isExpanded: storyLineItem.isExpanded)
            cell.onMoreButtonTapped = { [weak self] in
                self?.toggleStoryLine(at: indexPath)
            }
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
                withReuseIdentifier: Titles.headerCell,
                for: indexPath
            ) as! HeaderCell
            cell.update(with: item)
            return cell
        }
    }
    
    // Функция для переключения состояния story line
    private func toggleStoryLine(at indexPath: IndexPath) {
        guard let itemIndex = items.firstIndex(
            where: {
                if case .storyLine = $0 {
                    return true
                } else {
                    return false
                }
            }
        ),
              case let .storyLine(
                storyLineItem
              ) = items[itemIndex] else {
            return
        }
        
        var updatedStoryLineItem = storyLineItem
        updatedStoryLineItem.isExpanded.toggle()
        items[itemIndex] = .storyLine(item: updatedStoryLineItem)
        
        collectionView.performBatchUpdates({
            self.collectionView.reloadItems(at: [indexPath])
        }) { _ in
            // После обновления ячейки, возможно, потребуется обновить layout
            self.collectionView.layoutIfNeeded()
        }
    }
}

// MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    func closeShareView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.shareView?.alpha = 0
        }) { _ in
            self.blurEffectView?.removeFromSuperview()
        }
    }
    
    func shareToInstagram(movieName: String, movieId: Int) {
        uiActivityVC(movieName: movieName, movieId: movieId)
    }
    
    func shareToTwitter(movieName: String) {
        let tweetText = "\(movieName)"
        let tweetUrl = "http://yourappwebsite.com"
        let tweetHashtags = "AwesomeApp"
        
        if let tweetScheme = URL(string: "twitter://post?message=\(tweetText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&hashtags=\(tweetHashtags)") {
            if UIApplication.shared.canOpenURL(tweetScheme) {
                UIApplication.shared.open(tweetScheme)
            } else if let tweetWebUrl = URL(string: "https://twitter.com/intent/tweet?text=\(tweetText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&url=\(tweetUrl)&hashtags=\(tweetHashtags)") {
                UIApplication.shared.open(tweetWebUrl)
            }
        }
    }
    
    func shareToFacebook(movieName: String, movieId: Int) {
        uiActivityVC(movieName: movieName, movieId: movieId)
    }
    
    func shareToMessenger(movieName: String, movieId: Int) {
        uiActivityVC(movieName: movieName, movieId: movieId)
    }
    
    func uiActivityVC(movieName: String, movieId: Int) {
        let textToShare = "Проверьте этот фильм: \(movieName)"
        let urlToShare = URL(string: "https://www.kinopoisk.ru/film/\(movieId)")!

        let itemsToShare: [Any] = [textToShare, urlToShare]
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)

        // Исключить нежелательные типы активности
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.assignToContact, UIActivity.ActivityType.print, UIActivity.ActivityType.saveToCameraRoll]

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func playVideo(url: String) {
        guard let videoURL = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let webViewController = UIViewController()
        let webView = WKWebView(frame: webViewController.view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webViewController.view.addSubview(webView)
        
        let request = URLRequest(url: videoURL)
        webView.load(request)
        
        present(webViewController, animated: true, completion: nil)
    }
    
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
            
            self.setNavigationBar(title: model.title)
            
            let rightNavButton = CustomBarItem.shared.createCustomButton(
                target: self,
                action: #selector(
                    self.didTapLikeBarButton
                )
            )
            if model.likeBarButtonAction != nil {
                self.navigationItem.rightBarButtonItem = rightNavButton
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
                        movieClosure: model.header.movieClosure,
                        shareClosure: model.header.shareClosure)))
            self.items.append(
                .storyLine(item: model.storyLine))
            self.items.append(.castAndCrew)
            self.items.append(.gallery)
            
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Actions
    
    func showLoading() {
        collectionView.isHidden = true
    }
    
    func hideLoading() {
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
            let imageURL: String?
            let duration: Int?
            let genre: String?
            let rating: Double?
            let year: Int?
            let trailerClosure: (() -> Void)
            let movieClosure: (() -> Void)
            let shareClosure: (() -> Void)
        }
        
        struct CastAndCrewItem {
            let imageURL: String?
            let name: String?
            let profession: String?
        }
        
        struct GalleryItem {
            let imageURL: String?
        }
        
        struct StoryLineItem {
            let text: String
            var isExpanded: Bool = false
        }
        
        enum Item {
            case header(item: DetailHeaderView.Model)
            case storyLine(item: StoryLineItem)
            case castAndCrew
            case gallery
        }
        
        let title: String
        let header: HeaderItem
        var storyLine: StoryLineItem
        let castAndCrew: [CastAndCrewItem]
        let gallery: [GalleryItem]
        let likeBarButtonAction: (() -> Void)?
        var items = [Item]()
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentInsetTop = scrollView.contentInset.top
        
        if offsetY >= -contentInsetTop {
            // The top of the content is at the top of the view, enable bounce
            collectionView.alwaysBounceVertical = true
        } else {
            // The top of the content has been pulled below the top of the view, disable bounce
            collectionView.alwaysBounceVertical = false
        }
    }
}

// MARK: - Constants
private enum Titles {
    static let headerCell = "headerCell"
    static let reuseIdentifier = "section-header-reuse-identifier"
    static let movieDetail = "Movie Detail"
    static let storyLineHeader = "Story Line"
    static let castAndCrewHeader = "Cast and Crew"
    static let galeryHeader = "Gallery"
}

private enum LayoutConstants {
    static let headerHeight: CGFloat = 650
    static let storyLineWidthSubtraction: CGFloat = 50
    static let storyLineHeight: CGFloat = 150
    static let castHeight: CGFloat = 60
    static let galleryHeight: CGFloat = 180
    static let sectionsHeight: CGFloat = 40
}
