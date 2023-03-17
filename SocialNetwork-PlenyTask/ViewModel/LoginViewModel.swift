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
    
    func signIn(completion: @escaping (User?, Error?) -> Void) {
        Services.shared.signIn(username: username, password: password, completion: completion)
    }
    
}
