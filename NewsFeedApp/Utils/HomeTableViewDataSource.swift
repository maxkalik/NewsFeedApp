//
//  HomeTableViewDataSource.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/6/21.
//

import UIKit

class HomeTableViewDataSource: NSObject, UITableViewDataSource {
    let tableView: UITableView
    var dataList: [String]
    
    init(tableView: UITableView, dataList: [String]) {
        print("table view data source init", dataList)
        self.tableView = tableView
        self.dataList = dataList
        super.init()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? HomeTableViewCell {
            cell.titleLabel.text = dataList[indexPath.row]
            cell.dateLabel.text = "2 hours ago"
            return cell
        }
        return UITableViewCell()
    }
}

extension HomeTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func insertRow(with data: String) {
        dataList.insert(data, at: 0)
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
    }
}
