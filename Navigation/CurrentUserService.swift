//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Anton Kruglov on 25.09.2026.
//

import Foundation
import UIKit

class CurrentUserService: UserService {
    
    let user: User
    
    init(user: User) {
        self.user = user
    }

    func checkLogin(login: String) -> User? {
        if user.login == login {
            return user
        } else {
           return nil
        }
    }
}
