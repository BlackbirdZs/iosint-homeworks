//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Anton Kruglov on 22.10.2026.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let loginVc = LogInViewController()
        loginVc.coordinator = self

        let factory = MyLoginFactory()
        loginVc.loginDelegate = factory.makeLoginInspector()

        navigationController.pushViewController(loginVc, animated: false)
    }

    func openProfile(_ user: User) {
        parentCoordinator?.showUser(user)
        finish()
    }

    func finish() {
        parentCoordinator?.childCoordinators.removeAll { $0 === self }
    }
}
