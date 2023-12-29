//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import UIKit

private enum Titles {
    static let filmInfo = "FilmInfo"
}

class DetailViewController: UIViewController {
    
    typealias TextCell = TableCell<UILabel>
    var presenter: BookOutput!
    
    private lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(TableCell.self, forCellReuseIdentifier: Titles.filmInfo)
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Titles.filmInfo,
            for: indexPath) as! SpaceCell
        return cell
    }
}
