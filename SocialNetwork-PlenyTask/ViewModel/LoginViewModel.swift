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
    
    
    func login() {
        LoginService().login(username: username, password: password) { result in
            
            switch result {
                
            case .success(let token):
                print(token)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
