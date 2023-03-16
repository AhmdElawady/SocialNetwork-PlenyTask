//
//  PostsView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/16/23.
//

import SwiftUI

struct PostsView: View {
    
    @State private var posts: [Post] = []
    @StateObject var postsViewModel = PostsViewModel()
    
    var body: some View {
        NavigationStack {
            ReusablePostView(posts: $posts)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image("LOGO")
                            .resizable()
                            .frame(width: 60, height: 16)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                        })
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
        .environmentObject(postsViewModel)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
