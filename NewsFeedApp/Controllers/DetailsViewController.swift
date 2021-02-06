//
//  DetailsViewController.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/6/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var selectedLink: String?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("details view")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedLink ?? "")
        getDocument(from: selectedLink)
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        title = "details View"
    }
    
    deinit {
        print("deinit details view controller")
    }
    
    private func getDocument(from link: String?) {
        guard let url = link else { return }
        NetworkService.shared.fetchNewsDetails(fromLink: url) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
