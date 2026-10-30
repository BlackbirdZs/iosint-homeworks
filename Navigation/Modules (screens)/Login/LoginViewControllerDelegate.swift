//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Anton Kruglov on 29.09.2026.
//

import Foundation

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}
