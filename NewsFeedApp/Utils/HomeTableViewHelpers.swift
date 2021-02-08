//
//  HomeTableViewHelpers.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/8/21.
//

import UIKit

final class HomeTableViewHelpers {
    static let shared = HomeTableViewHelpers()
    private init() {}
    
    func configureCell(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == dataList.count {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as? LoadingTableViewCell {
                cell.startAnimating()
                delegate?.loadNextBatch()
                return cell
            }
        }
        let post = dataList[indexPath.row]
        if post.picture != nil, let cellWithPicture = tableView.dequeueReusableCell(withIdentifier: "homeCellWithPicture", for: indexPath) as? HomeTableViewCellWithPicture {
            cellWithPicture.configure(with: post)
            return cellWithPicture
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? HomeTableViewCell {
            cell.configure(with: post)
            return cell
        }
        return UITableViewCell()
    }
}
