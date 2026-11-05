//
//  AuthError.swift
//  Navigation
//
//  Created by Anton Kruglov on 03.11.2026.
//

import Foundation

enum AuthError: Error {
    case invalidLoginOrPassword
    case emptyFields
    case noUser
}
