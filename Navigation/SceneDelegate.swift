//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Anton Kruglov on 31.07.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: scene)

        let feedViewController = FeedViewController()
        feedViewController.title = "User feed"
        feedViewController.view.backgroundColor = .systemBlue

        let loginViewController = LogInViewController()
        loginViewController.view.backgroundColor = .white

        let tabBarController = UITabBarController()

        feedViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        loginViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)

        feedViewController.tabBarItem.image = UIImage(systemName: "square.fill.text.grid.1x2")
        loginViewController.tabBarItem.image = UIImage(systemName: "person.crop.rectangle.stack")

        let controllers = [feedViewController, loginViewController]
        tabBarController.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }

        tabBarController.selectedIndex = 1

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        self.window = window
    }
}
