//
//  User.swift
//  Navigation
//
//  Created by Anton Kruglov on 25.09.2026.
//

import Foundation
import UIKit

class User {
    let login: String
    var fullName: String
    var status: String
    var avatar: UIImage
    
    init(login: String, fullName: String, status: String, avatar: UIImage) {
        self.login = login
        self.fullName = fullName
        self.status = status
        self.avatar = avatar
    }
}
