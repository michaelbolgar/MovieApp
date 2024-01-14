//
//  SearchBarView.swift
//  MovieApp
//
//  Created by Yerlan Omarov on 26.12.2023.
//

import UIKit

final class SearchBarView: UIView {
    weak var delegate: SearchBarViewDelegate?
    var searchIcon: String = "magnifyingglass"
    
    // MARK: - UI Properties
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        let image = UIImage(systemName: searchIcon)?.withTintColor(.clear, renderingMode: .alwaysOriginal)
        search.setImage(image, for: .search, state: .normal)
        search.delegate = self
        #warning("fix color")
        search.barTintColor = .customBlack
        search.tintColor = .customBlue
        search.searchTextPositionAdjustment = UIOffset(horizontal: 5, vertical: 0)
        search.searchTextField.placeholder = "Search"
        search.searchTextField.textColor = .customWhiteGrey
        return search
    }()
    
    private lazy var searchButton: UIButton = {
        let image = UIImage(systemName: searchIcon)
        let action = UIAction(image: image, handler: searchAction)
        let button = UIButton(type: .system, primaryAction: action)
        button.isEnabled = false
        return button
    }()

    // MARK: - Initializators
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    // MARK: - Layout Private Methods
    private func layout() {
        addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchBar.addSubview(searchButton)
        searchButton.snp.makeConstraints {
            $0.top.leading.equalTo(searchBar.searchTextField).inset(5)
        }
    }
    
    // MARK: - Private Methods
    private func searchAction(_ action: UIAction) {
        searchBarSearchButtonClicked(searchBar)
    }
    
    // MARK: - Internal Methods
    func toggleSearchButton(with value: Bool) {
        searchButton.isEnabled = value
    }
}
