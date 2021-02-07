//
//  HomeViewController.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/5/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    let tableView = UITableView()
    private var tableViewDataSource: HomeTableViewDataSource?
    
    weak var coordinator: MainCoordinator?
    var safeArea: UILayoutGuide!
    
    var data = [Post]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        getNewsFeed()
        setupTableView()
        title = "News Feed"
    }
    
    private func setupTableView() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        
        tableView.separatorStyle = .none
        
        
        tableViewDataSource = HomeTableViewDataSource(tableView: tableView)
    }
    
    private func getNewsFeed() {
        NetworkService.shared.fetchNewsFeed(fromPage: 1) { result in
            switch result {
            case .success(let data):
                print(data.documents.count)
                DispatchQueue.main.async {
                    for item in data.documents {
                        self.tableViewDataSource?.insertRow(with: item)
                    }
                }
                

                // self.getDocument(from: data.documents.first?.url)
                // self.selectedLink = data.documents.first?.url
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

