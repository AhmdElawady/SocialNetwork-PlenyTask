//
//  PostsView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/16/23.
//

import SwiftUI

struct PostsView: View {
    
    @EnvironmentObject var postsViewModel: PostsViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                if postsViewModel.posts.isEmpty {
                    ProgressView()
                        .padding(.top, 30)
                } else {
                    VStack {
                        if postsViewModel.posts.isEmpty {
                            Text("No Posts Found")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.top, 30)
                        } else {
                            // display posts
                            ForEach(postsViewModel.posts) { post in
                                PostCardView(post: post, staticPost: postsViewModel.localData)
                            }
                        }
                        
                        if postsViewModel.skipCount == postsViewModel.posts.count {
                            ProgressView()
                                .padding(.vertical)
                                .onAppear(perform: {
                                    postsViewModel.fetchPosts()
                                })
                        } else {
                            GeometryReader { reader -> Color in
                                let minY = reader.frame(in: .global).minY
                                let height = UIScreen.main.bounds.height/1.3
                                
                                if !postsViewModel.posts.isEmpty && minY < height {
                                    DispatchQueue.main.async {
                                        postsViewModel.skipCount = postsViewModel.posts.count
                                    }
                                }
                                return Color.clear
                            }
                            .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.vertical)
                }
            })
            .environmentObject(postsViewModel)
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
                            .toolbar(.hidden, for: .tabBar)
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .tint(.black)
                            .scaleEffect(0.9)
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
        .refreshable {
            // Scroll to refresh
            if postsViewModel.posts.isEmpty {
                postsViewModel.posts = []
                postsViewModel.fetchPosts()
            }
        }
        .task {
            // Fetch posts one time
            guard postsViewModel.posts.isEmpty else { return }
            postsViewModel.fetchPosts()
        }
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
