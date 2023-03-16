//
//  LoginViewModel.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/16/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    var username: String = ""
    var password: String = ""
    
    func login(completion: @escaping (Result<User, AuthenticationError>) -> Void) {
        LoginService().login(username: username, password: password, completion: completion)
    }
    
}
