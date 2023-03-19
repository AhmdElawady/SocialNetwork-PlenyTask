//
//  SearchPostsView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/17/23.
//

import SwiftUI

struct SearchPostsView: View {
    
    @EnvironmentObject var postsViewModel: PostsViewModel
//    @State private var posts: [Post] = []
    @State private var searchText: String = ""
    @State var isFetching: Bool = false
    
    var body: some View {
        if postsViewModel.isFetching {
            ProgressView()
                .padding(.top, 35)
        } else {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    if postsViewModel.searchedPosts.isEmpty {
                        Text("No Posts Found")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 30)
                    } else {
                        // display posts
                        ForEach(postsViewModel.searchedPosts) { post in
                            PostCardView(post: post, staticPost: postsViewModel.localData)
                        }
                    }
                }
                .padding(.vertical)
                
            })
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Search Posts")
            
            .searchable(text: $postsViewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: searchText, perform: { newValue in
                Task {
                    postsViewModel.fetchSearchedPosts()
                }
                if newValue.isEmpty {
                    postsViewModel.searchedPosts = []
                }
            })
            
        }
    }
}

struct SearchPostsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPostsView()
    }
}
