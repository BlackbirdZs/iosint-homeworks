//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Anton Kruglov on 21.10.2026.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let profileVc = ProfileViewController()
        profileVc.coordinator = self
        navigationController.pushViewController(profileVc, animated: false)
    }

    func openPhotos() {
        let photosVc = PhotosViewController()
        navigationController.pushViewController(photosVc, animated: true)
    }
}
