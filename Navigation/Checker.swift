//
//  Checker.swift
//  Navigation
//
//  Created by Anton Kruglov on 29.09.2026.
//

import Foundation

class Checker {
    static let shared: Checker = {
        let instance = Checker()
        return instance
    }()

    private init() {}

    private let login: String = "admin"

    private let password: String = "admin"

    func check(login: String, password: String) -> Bool {
        if login == self.login && password == self.password {
            return true
        } else {
            return false
        }
    }
}
