//
//  Coordinator.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/5/21.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}
