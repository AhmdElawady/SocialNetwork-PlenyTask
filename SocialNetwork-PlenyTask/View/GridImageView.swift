//
//  GridImageView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/15/23.
//

import SwiftUI

struct GridImageView: View {
    
    @EnvironmentObject var feedData: FeedViewModel
    var index: Int
    
    var body: some View {
        
        Button(action: {
            withAnimation(.easeInOut) {
                feedData.selectedCriteria = 1
                feedData.selectedImageID = feedData.feedImages[index]
                feedData.showImageViewer.toggle()
            }
        }, label: {
            ZStack {
                // limit images preview of Four
                if index <= 3 {
                    Image(feedData.feedImages[index])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getWidth(index: index), height: 170)
                        .cornerRadius(8)
                }
                
                // Add a highlight view with counter if images more than Four
                if feedData.feedImages.count > 4 && index == 3 {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.black.opacity(0.5))
                    
                    let restImages = feedData.feedImages.count-4
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

        if feedData.feedImages.count % 2 == 0 {
            return width/2
        } else {
            if index == feedData.feedImages.count - 1 {
                return width
            } else {
                return width/2-5 // 5 point spacing between two iamges
            }
        }
    }
}

struct GridImageView_Previews: PreviewProvider {
    static var previews: some View {
//        GridImageView()
        ContentView()
    }
}




extension View {
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
