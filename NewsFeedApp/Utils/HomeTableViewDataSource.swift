//
//  HomeTableViewDataSource.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/6/21.
//

import UIKit

class HomeTableViewDataSource: NSObject, UITableViewDataSource {
    let tableView: UITableView
    var dataList = [Post]()
    
    init(tableView: UITableView) {
        print("table view data source init", dataList)
        self.tableView = tableView
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
            let post = dataList[indexPath.row]
            cell.titleLabel.text = post.title
            cell.subTitleLabel.text = post.secondTitle
            cell.dateLabel.text = Helpers.shared.getDateDifference(from: post.datetime)
            
            guard let imageUrlString = post.picture?.mobileRetinaUrl, let imageUrl = URL(string: Settings.hostname + imageUrlString) else { return cell }
            cell.postImageView.load(from: imageUrl)
            
            // print(Settings.hostname + imageUrlString)
            
            return cell
        }
        return UITableViewCell()
    }
}

extension HomeTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func insertRow(with data: Post) {
        dataList.insert(data, at: 0)
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
    }
}
