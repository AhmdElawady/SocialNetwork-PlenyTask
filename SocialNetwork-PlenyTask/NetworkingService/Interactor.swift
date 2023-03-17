//
//  Interactor.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/17/23.
//

import Foundation

class Services {
    
    static let shared = Services()
    let genaricOperation = GenaricOperation()
    
    // Signin Service
    func signIn(username: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        let body = LoginRequestBody(username: username, password: password)
        let url = URL(string: URLHelper.EndPoints.login.stringValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        genaricOperation.postRequest(request: request, completion: completion)
    }
    
    // Fetch Posts
    func fetchPosts(completion: @escaping (PostResponseBody?, Error?) -> Void) {
        let urlString = URLHelper.EndPoints.posts.stringValue
        genaricOperation.getRequest(urlString: urlString, completion: completion)
    }
    
    // Fetch Searched Posts
    func fetchSearchedPosts(searchTerm: String, completion: @escaping (PostResponseBody?, Error?) -> Void) {
        let urlString = "\(URLHelper.EndPoints.searchPosts.stringValue)\(searchTerm)"
        let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        genaricOperation.getRequest(urlString: urlStringEncoded ?? "", completion: completion)
    }
}
