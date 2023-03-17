//
//  GridImageView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/15/23.
//

import SwiftUI

struct GridImageView: View {
    
    @EnvironmentObject var postsViewModel: PostsViewModel
    var index: Int
    var staticPost: StaticPostData
    
    var body: some View {
        
        Button(action: {
            withAnimation(.easeInOut) {
                postsViewModel.selectedCriteria = 1
                postsViewModel.selectedImageID = staticPost.postImages[index]
                postsViewModel.showImageViewer.toggle()
            }
        }, label: {
            ZStack {
                // limit images preview of Four
                if index <= 3 {
                    Image(staticPost.postImages[index])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getWidth(index: index), height: 170)
                        .cornerRadius(8)
                }
                
                // Add a highlight view with counter if images more than Four
                if staticPost.postImages.count > 4 && index == 3 {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.black.opacity(0.5))
                    
                    let restImages = staticPost.postImages.count-4
                    Text("+\(restImages)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
        })
    }
    
    // Expanding image sizes if there is spaces or images less than 4
    func getWidth(index: Int) -> CGFloat {
        let width = getRect().width - 20

        if staticPost.postImages.count % 2 == 0 {
            return width/2
        } else {
            if index == staticPost.postImages.count - 1 {
                return width
            } else {
                return width/2-5 // 5 point spacing between two iamges
            }
        }
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
