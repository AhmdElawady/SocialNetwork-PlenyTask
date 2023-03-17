//
//  SearchPostsView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/17/23.
//

import SwiftUI

struct SearchPostsView: View {
    
    @State private var posts: [Post] = []
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {

            ReusablePostView(posts: $posts)
            
            .listStyle(.plain)
            .navigationTitle("Search Posts")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
            .onSubmit(of: .search, {
                // search posts
            })
        }
    }
}

struct SearchPostsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPostsView()
    }
}
