//
//  TestUserService.swift
//  Navigation
//
//  Created by Anton Kruglov on 28.09.2026.
//

import Foundation
import UIKit

class TestUserService: UserService {
    
    let testUser = User(
        login: "testUser",
        fullName: "Test User",
        status: "Test",
        avatar: UIImage(named: "avatar") ?? UIImage()
    )

    func checkLogin(login: String) -> User? {
        return testUser.login == login ? testUser : nil
    }
}
