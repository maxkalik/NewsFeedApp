//
//  HomeViewController.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/5/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    var selectedLink: String?
    
    private lazy var helloLabel: UILabel = {
        let helloLabel = UILabel()
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        helloLabel.text = "Hello!"
        return helloLabel
    }()
    
    private lazy var someButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 200, y: 200, width: 50, height: 50))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        title = "Welcome"
        
        configureSubviews()
        setupConstrains()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsFeed()
    }
    
    private func configureSubviews() {
        view.addSubview(helloLabel)
        configureButton()
    }
    
    private func configureButton() {
        someButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(someButton)
    }
    
    @objc func buttonTapped() {
        coordinator?.toDetails(with: selectedLink)
    }
    
    private func setupConstrains() {
        helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        someButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        someButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -50).isActive = true
        
        someButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        someButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func getNewsFeed() {
        NetworkService.shared.fetchNewsFeed(fromPage: 1) { result in
            switch result {
            case .success(let data):
                print(data.documents.count)
                // self.getDocument(from: data.documents.first?.url)
                self.selectedLink = data.documents.first?.url
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
}
