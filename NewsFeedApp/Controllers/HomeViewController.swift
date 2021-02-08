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
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    weak var coordinator: MainCoordinator?
    var safeArea: UILayoutGuide!
    var currentPage: Int = 1
    
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
        setupTableView()
        title = "News Feed"
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        currentPage = 1
        tableViewDataSource?.refresh()
        sender.endRefreshing()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)

        tableView.refreshControl = refreshControl
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        tableView.separatorStyle = .none
        
        tableViewDataSource = HomeTableViewDataSource(tableView: tableView)
        tableViewDataSource?.delegate = self
    }
    
    private func getNewsFeed(from page: Int) {
        self.currentPage += 1
        NetworkService.shared.fetchNewsFeed(fromPage: page, perPage: 20) { result in
            switch result {
            case .success(let data):
                let news = data.documents.sorted { $0.datetime > $1.datetime }
                self.tableViewDataSource?.update(with: news)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension HomeViewController: HomeTableViewDelegate {
    func loadNextBatch() {
        getNewsFeed(from: currentPage)
    }
    
    func didSelectRow(with link: String?) {
        coordinator?.toDetails(with: link)
    }
}
