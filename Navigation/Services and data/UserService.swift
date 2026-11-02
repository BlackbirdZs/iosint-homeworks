//
//  UserService.swift
//  Navigation
//
//  Created by Anton Kruglov on 25.09.2026.
//

import Foundation

protocol UserService {
    func checkLogin(login: String) -> User?
}
