//
//  MainCoordinator.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/5/21.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.navigationController = UINavigationController()
        self.window = window
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let viewController = HomeViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toDetails(with link: String?) {
        let viewController = DetailsViewController()
        viewController.selectedLink = link
        navigationController.pushViewController(viewController, animated: true)
    }
    
    deinit {
        print("Main Coordinator Deinit")
    }
}
