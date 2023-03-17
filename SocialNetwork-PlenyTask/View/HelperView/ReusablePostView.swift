//
//  ReusablePostView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/17/23.
//

import SwiftUI

struct ReusablePostView: View {
    var posts: [Post] = []
    @StateObject var postsViewModel = PostsViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                if posts.isEmpty {
                    Text("No Posts Found")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 30 )
                } else {
                    // display posts
                    Posts()
                }
            }
        }
    }
    
    @ViewBuilder
    func Posts() -> some View {
        ForEach(posts) { post in
            PostCardView(post: post, staticPost: postsViewModel.postData.randomElement()!)
        }
    }
}
