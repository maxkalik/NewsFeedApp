//
//  SceneDelegate.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/4/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window!.windowScene = windowScene
        coordinator = MainCoordinator(window: window!)
        coordinator!.start()
    }

}

