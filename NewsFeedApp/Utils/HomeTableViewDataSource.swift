//
//  HomeTableViewDataSource.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/6/21.
//

import UIKit

protocol HomeTableViewDelegate: HomeViewController {
    func loadNextBatch()
    func didSelectRow(with link: String?)
}

class HomeTableViewDataSource: NSObject, UITableViewDataSource {
    let tableView: UITableView
    var dataList = [Post]()
    weak var delegate: HomeTableViewDelegate?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()

        registerCells()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func registerCells() {
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: "loadingCell")
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeCell")
        tableView.register(HomeTableViewCellWithPicture.self, forCellReuseIdentifier: "homeCellWithPicture")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == dataList.count {
            return 50.0
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == dataList.count {
            delegate?.loadNextBatch()
            if let spinnerCell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as? LoadingTableViewCell {
                if indexPath.row != 0 { spinnerCell.startAnimating() }
                return spinnerCell
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

    func refresh() {
        dataList.removeAll()
        tableView.reloadData()
    }
}
