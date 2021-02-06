//
//  ViewController.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/4/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsFeed()
    }
    
    func getNewsFeed() {
        NetworkService.shared.fetchNewsFeed(fromPage: 1) { result in
            switch result {
            case .success(let data):
                print(data.documents.count)
                self.getDocument(from: data.documents.first?.url)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getDocument(from link: String?) {
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

