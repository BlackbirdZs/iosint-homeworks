//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Anton Kruglov on 21.10.2026.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var profileNavigationController = UINavigationController()
    var loginNavigationController = UINavigationController()
    var window: UIWindow
    var tabBarController = UITabBarController()

    init(window: UIWindow) {
        navigationController = UINavigationController()
        self.window = window
    }

    func start() {
        let feedCoordinator = FeedCoordinator(navigationController: navigationController)
        feedCoordinator.parentCoordinator = self
        childCoordinators.append(feedCoordinator)
        feedCoordinator.start()
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        navigationController.tabBarItem.image = UIImage(systemName: "square.fill.text.grid.1x2")

        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        profileCoordinator.parentCoordinator = self
        childCoordinators.append(profileCoordinator)
        profileCoordinator.start()
        profileNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        profileNavigationController.tabBarItem.image = UIImage(systemName: "figure")

        let loginCoordinator = LoginCoordinator(navigationController: loginNavigationController)
        loginCoordinator.parentCoordinator = self
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
        loginNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 2)
        loginNavigationController.tabBarItem.image = UIImage(systemName: "person.crop.rectangle.stack")

        tabBarController.viewControllers = [navigationController, profileNavigationController, loginNavigationController]
        tabBarController.selectedIndex = 2
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
