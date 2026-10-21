//
//  Coordinator.swift
//  Navigation
//
//  Created by Anton Kruglov on 21.10.2026.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
