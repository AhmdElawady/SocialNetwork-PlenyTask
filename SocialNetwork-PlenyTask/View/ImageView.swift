//
//  ImageView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/15/23.
//

import SwiftUI

struct ImageView: View {
    
    @EnvironmentObject var feedData: FeedViewModel
    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            // View profile picture
            if feedData.selectedCriteria == 0 {
                Image(feedData.userProfilePic)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            } else {
                // View feed images
                TabView(selection: $feedData.selectedImageID) {
                    ForEach(feedData.feedImages, id: \.self) { image in
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
                    feedData.showImageViewer.toggle()
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

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
