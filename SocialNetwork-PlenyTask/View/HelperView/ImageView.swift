//
//  ImageView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/15/23.
//

import SwiftUI

struct ImageView: View {
    
    @EnvironmentObject var postViewModel: PostsViewModel
//    var staticPost: StaticPostData
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            // View profile picture
            if postViewModel.selectedCriteria == 0 {
                
                Image(postViewModel.localData.profilePic)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            } else {
                // View feed images
                TabView(selection: $postViewModel.selectedImageID) {
                    ForEach(postViewModel.localData.postImages, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .tag(image)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            }
        }
        .overlay (
            // Close Button
            Button(action: {
                withAnimation(.default) {
                    postViewModel.showImageViewer.toggle()
                }
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white.opacity(0.35))
                    .clipShape(Circle())
            })
            .padding(10)
            ,alignment: .topTrailing
        )
    }
}
