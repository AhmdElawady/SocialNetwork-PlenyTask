//
//  SearchPostsView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/17/23.
//

import SwiftUI

struct SearchPostsView: View {
    
    @StateObject var postsViewModel = PostsViewModel()
    @State private var posts: [Post] = []
    @State private var searchText: String = ""
    @State var isFetching: Bool = false
    
    var body: some View {
        if isFetching {
            ProgressView()
                .padding(.top, 35)
        } else {
            ReusablePostView(posts: posts)
                .listStyle(.plain)
                .navigationTitle("Search Posts")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .onChange(of: searchText, perform: { newValue in
                    Task { searchPosts() }
                    if newValue.isEmpty {
                        posts = []
                    }
                })
        }
    }
    func searchPosts() {
        isFetching = true
        let textLoweerCased = searchText.lowercased()
        postsViewModel.fetchSearchedPosts(searchTerm: textLoweerCased) { posts, error in
            if error != nil && posts == nil { print("Fetch posts error \(String(describing: error))") }
            self.posts = posts?.posts ?? []
        }
        isFetching = false
    }
}

struct SearchPostsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPostsView()
    }
}
