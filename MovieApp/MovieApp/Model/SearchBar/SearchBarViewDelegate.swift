//
//  SearchBarViewDelegate.swift
//  MovieApp
//
//  Created by Yerlan Omarov on 26.12.2023.
//

import UIKit

// Similar to UISearchBarDelegate, but only 2 methods for search
protocol SearchBarViewDelegate: AnyObject {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
}
