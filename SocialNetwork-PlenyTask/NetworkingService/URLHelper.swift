//
//  URLHelper.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/17/23.
//

import Foundation


class URLHelper {
    
    static let baseUrl = "https://dummyjson.com"
    
    
    enum EndPoints {
          case login
          case posts
          case searchPosts
          
          var stringValue: String {
              switch self {
              case .login: return
                  baseUrl+"/auth/login"
              case .posts: return
                  baseUrl + "/posts"
              case .searchPosts: return
                  baseUrl + "/posts/search?q="
              }
          }
      }
}
