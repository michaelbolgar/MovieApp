//
//  SearchBarView + Extensions.swift
//  MovieApp
//
//  Created by Yerlan Omarov on 26.12.2023.
//

import UIKit

// MARK: - UISearchBarDelegate Methods
extension SearchBarView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        toggleSearchButton(with: !searchText.isEmpty)
        delegate?.searchBar(searchBar, textDidChange: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismiss(searchBar)
        delegate?.searchBarSearchButtonClicked(searchBar)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        toggleSearchButton(with: !(searchBar.text?.isEmpty ?? true))
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        toggleSearchButton(with: false)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelAction(with: searchBar)
    }
}

// MARK: - Private Methods
extension SearchBarView {
    private func withAnimation(animatable: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5) {
            animatable()
        }
    }
    
    private func dismiss(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    private func cancelAction(with searchBar: UISearchBar) {
        withAnimation { [self] in
            searchBar.text = nil
            searchBar.showsCancelButton = false
            dismiss(searchBar)

            layoutIfNeeded()
        }
    }
}
