//
//  LoginFactory.swift
//  Navigation
//
//  Created by Anton Kruglov on 29.09.2026.
//

import Foundation

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}
