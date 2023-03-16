//
//  ReusablePostView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/16/23.
//

import SwiftUI

struct ReusablePostView: View {
    @Binding var posts: [Post]
    @StateObject var postsViewModel = PostsViewModel()
    @State var isFetching: Bool = true
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                if isFetching {
                    ProgressView()
                        .padding(.top, 40)
                } else {
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
        .refreshable {
            // Scroll to refresh
            isFetching = true
            posts = []
            getPosts()
        }
        
        .task {
            // Fetch posts one time
            guard posts.isEmpty else { return }
            getPosts()
        }
    }
    
    @ViewBuilder
    func Posts() -> some View {
        ForEach(posts) { post in
//            Text(post.body)
            PostCardView(post: post, staticPost: postsViewModel.postData.randomElement()!)
        }
    }
    
    func getPosts() { // get all posts
        postsViewModel.getPosts { posts, error in
            if error == nil {
                self.posts = posts
            }
            isFetching = false
        }
    }
}

struct ReusablePostView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
