//
//  HomeTableViewDataSource+UITableViewDelegates.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/9/21.
//

import UIKit

extension HomeTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRow(with: dataList[indexPath.row].url)
    }
    
    func update(with data: [Post]) {
        dataList += data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
