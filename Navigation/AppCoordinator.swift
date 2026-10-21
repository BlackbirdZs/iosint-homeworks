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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func showProfile() {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        profileCoordinator.parentCoordinator = self
        childCoordinators.append(profileCoordinator)
        profileCoordinator.start()
    }
    
    func showFeed() {
        let feedCoordinator = FeedCoordinator(navigationController: navigationController)
        feedCoordinator.parentCoordinator = self
        childCoordinators.append(feedCoordinator)
        feedCoordinator.start()
    }
}

