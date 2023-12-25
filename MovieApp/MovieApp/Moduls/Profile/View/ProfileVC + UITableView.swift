//
//  ProfileVC + UITableView.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 25.12.2023.
//

import UIKit

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.reuseID, for: indexPath) as? ProfileCell else {

                return UITableViewCell()
            }
            
            
            
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 112
        } else {
            return 0
        }
    }
}
