//
//  LoginInspector.swift
//  Navigation
//
//  Created by Anton Kruglov on 29.09.2026.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
    }

    var loginDelegate: LoginViewControllerDelegate?
}
