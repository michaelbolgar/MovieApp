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
    static let storyLineTitle = "Story Line"
    static let castAndCrewTitle = "Cast and Crew"
    static let galeryTitle = "Galery"
}

class DetailViewController: UIViewController {
    
    typealias HeaderCell = TableCell<DetailHeaderView>
    typealias TextCell = TableCell<UILabel>
    typealias CastAndCrewCell = CollectionCell<CastAndCrewView>
    
    var presenter: DetailOutput!
    
    private var items = [ViewModel.Item]()
    private var likeBarButtonAction: (() -> Void)?
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(
            CastAndCrewCell.self,
            forCellReuseIdentifier: Titles.castAndCrew
        )
        tv.register(
            TextCell.self,
            forCellReuseIdentifier: Titles.storyLineTitle
        )
        tv.register(
            HeaderCell.self,
            forCellReuseIdentifier: Titles.header
        )
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.allowsSelection = false
        tv.backgroundColor = .clear
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            switch items[section] {
            case .header(_):
                return nil
            case .storyLine(_):
                let label = UILabel.Model(
                    text: Titles.storyLineTitle,
                    textFont: .montserratSemiBold(ofSize: 16)
                    ?? .systemFont(ofSize: 16))
                return label.text.string
            case .castAndCrew:
                let label = UILabel.Model(
                    text: Titles.castAndCrewTitle,
                    textFont: .montserratSemiBold(ofSize: 16)
                    ?? .systemFont(ofSize: 16))
                return label.text.string
            case .gallery:
                let label = UILabel.Model(
                    text: Titles.galeryTitle,
                    textFont: .montserratSemiBold(ofSize: 16)
                    ?? .systemFont(ofSize: 16))
                return label.text.string
            }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        switch item {
        case .storyLine(item: let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: Titles.header, for: indexPath) as! TextCell
            cell.update(with: item)
            return cell
        case .castAndCrew:
            let cell = tableView.dequeueReusableCell(withIdentifier: Titles.castAndCrew, for: indexPath)
        case .gallery:
            <#code#>
        case .header(item: let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: Titles.header, for: indexPath) as! HeaderCell
            cell.update(with: item)
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension DetailViewController: DetailInput {
    func update(with model: ViewModel) {
        
        title = model.title
        
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
                    trailerClosure: model.header.trailerClosure,
                    shareClosure: model.header.shareClosure)))
        items.append(
            .storyLine(
                item: .init(text: model.storyLine)))
        items.append(.castAndCrew)
        items.append(.gallery)
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
            let imageURL: URL?
            let duration: String?
            let genre: String?
            let rating: String?
            let trailerClosure: (() -> Void)
            let shareClosure: (() -> Void)
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
        let likeBarButtonAction: (() -> Void)?
    }
}

