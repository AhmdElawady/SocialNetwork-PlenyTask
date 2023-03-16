//
//  PostService.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/16/23.
//

import Foundation


struct PostResponseBody: Codable {
    var posts: [Post]
    var total: Int
    var limit: Int
}

class PostService {
    
    func getPosts(completion: @escaping ([Post], Error?) -> ()) {
        guard let url = URL(string: "https://dummyjson.com/posts") else { return }
        
         let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
             guard let data = data, error == nil else {
                 completion([], error)
                 return
             }
             do {
                 let decoder = JSONDecoder()
                 let object = try decoder.decode(PostResponseBody.self, from: data)
                 completion(object.posts, nil)
             } catch {
                 completion([], error)
                 print("Failed to decode Data:", error)
             }
         }
         task.resume()
    }
}


