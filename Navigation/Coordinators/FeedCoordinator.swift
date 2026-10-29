//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Anton Kruglov on 21.10.2026.
//

import Foundation
import StorageService
import UIKit

class FeedCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    weak var parentCoordinator: AppCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let feedVC = FeedViewController()
        feedVC.coordinator = self
        navigationController.pushViewController(feedVC, animated: false)
    }

    func openPost(_ post: Post) {
        let postVc = PostViewController()
        postVc.post = post
        navigationController.pushViewController(postVc, animated: true)
    }
}
