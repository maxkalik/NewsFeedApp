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
    let spinner = UIActivityIndicatorView()
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    private let barButtonItem = UIBarButtonItem()
    weak var coordinator: MainCoordinator?
    private var safeArea: UILayoutGuide!
    private var currentPage: Int = 1
    private var currentLanguage = "en"
    private let defaults = UserDefaults.standard
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        commonSetup()
        setupTableView()
        setupTableViewConstraints()
        setupTitle()
        setupSpinner()
        setupSpinnerConstraints()
        setupRightBarButtonItem()
        
    }
    
    private func setupSpinner() {
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.style = .large
    }
    
    private func setupRightBarButtonItem() {
        currentLanguage = defaults.object(forKey: Settings.languageKey) as? String ?? "en"
        setupLanguageButtonTitle()
        navigationItem.rightBarButtonItem = barButtonItem
        barButtonItem.target = self
        barButtonItem.action = #selector(languageChanged)
    }
    
    private func setupLanguageButtonTitle() {
        barButtonItem.title = currentLanguage == "en" ? "RU" : "EN"
    }
    
    @objc func languageChanged() {
        currentLanguage = currentLanguage == "en" ? "ru" : "en"
        defaults.set(currentLanguage, forKey: Settings.languageKey)
        setupLanguageButtonTitle()
        startRefreshing()
    }
    
    private func startRefreshing() {
        currentPage = 1
        tableViewDataSource?.refresh()
    }
    
    private func commonSetup() {
        view = UIView()
        safeArea = view.layoutMarginsGuide
    }
    
    private func setupTitle() {
        let titleLabel = TitleLabel()
        titleLabel.textColor = .gray
        titleLabel.text = Helpers.shared.getDateToday()
        navigationItem.titleView = titleLabel
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        startRefreshing()
        sender.endRefreshing()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.refreshControl = refreshControl
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        tableViewDataSource = HomeTableViewDataSource(tableView: tableView)
        tableViewDataSource?.delegate = self
    }
    
    private func onSuccess(with posts: DecodedArray<Post>) {
        let news = posts.sorted { $0.datetime > $1.datetime }
        tableViewDataSource?.update(with: news)
        if currentPage <= 2 {
            DispatchQueue.main.async { [self] in
                spinner.stopAnimating()
            }
        }
    }
    
    private func onFailure() {
        simpleAlert(title: "Internet connection failure", msg: "For using News Feed App, you need to have internet connection on in your iPhone.")
        DispatchQueue.main.async { [self] in
            spinner.stopAnimating()
        }
    }
    
    private func getNewsFeed(from page: Int) {
        self.currentPage += 1
        NetworkService.shared.fetchNewsFeed(fromPage: page, perPage: 20, language: currentLanguage) { [self] result in
            switch result {
            case .success(let data): onSuccess(with: data.documents)
            case .failure(let error):
                print(error.localizedDescription)
                onFailure()
            }
        }
    }
}

// MARK: - HomeTableViewDelegate

extension HomeViewController: HomeTableViewDelegate {
    func loadNextBatch() {
        getNewsFeed(from: currentPage)
    }
    
    func didSelectRow(with link: String?) {
        coordinator?.toDetails(with: link)
    }
}
