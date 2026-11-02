//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Anton Kruglov on 29.09.2026.
//

import Foundation

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
