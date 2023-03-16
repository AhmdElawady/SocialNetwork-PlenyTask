//
//  LoginService.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/16/23.
//

import Foundation

enum AuthenticationError: Error {
    case invalideCredintial
    case custom(errorMessage: String )
}


struct LoginRequestBody: Codable {
    var username: String
    var password: String
}

struct LoginRespondeBody: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}

class LoginService {
    

    
    func login(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/auth/login") else {
            completion(.failure(.custom(errorMessage: "URL not valid")))
            return
        }
        
        
        let body = LoginRequestBody(username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.invalideCredintial))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(LoginRespondeBody.self, from: data)
                
                guard let token = responseObject.token else { return }
                completion(.success(token))
                
            } catch {
                completion(.failure(.invalideCredintial))
            }
            
        }.resume()
            
    }
}
