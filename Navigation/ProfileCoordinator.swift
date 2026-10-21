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
        let profileVC = ProfileViewController()
        navigationController.pushViewController(profileVC, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childCoordinators.removeAll { $0 === self }
//some code to be added later
    }
}
