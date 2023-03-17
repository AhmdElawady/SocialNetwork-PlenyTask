//
//  PostsView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/16/23.
//

import SwiftUI

struct PostsView: View {
    
    @State private var posts: [Post] = []
    @State private var staticData: StaticPostData?
    @StateObject var postsViewModel = PostsViewModel()
    @State var isFetching: Bool = true
    
    var body: some View {
        NavigationStack {
            if isFetching {
                ProgressView()
                    .padding(.top, 40)
            } else {
                ReusablePostView(posts: posts)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Image("LOGO")
                                .resizable()
                                .frame(width: 60, height: 16)
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink {
                                SearchPostsView()
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .tint(.black)
                                    .scaleEffect(0.9)
                            }
                        }
                    }
            }
        }
        .overlay(content: {
            // imageViewer
            ZStack {
                if postsViewModel.showImageViewer {
                    ImageView()
                }
            }
        })
//        .refreshable {
//            // Scroll to refresh
//            isFetching = true
//            posts = []
//            fetchPosts()
//        }
        
        .task {
            // Fetch posts one time
            guard posts.isEmpty else { return }
            fetchPosts()
        }
        .environmentObject(postsViewModel)
    }
    
    func fetchPosts() { // get all posts
        postsViewModel.fetchPosts { posts, error in
            if error != nil && posts == nil { print("Fetch posts error \(String(describing: error))") }
            self.posts = posts?.posts ?? []
            isFetching = false
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
