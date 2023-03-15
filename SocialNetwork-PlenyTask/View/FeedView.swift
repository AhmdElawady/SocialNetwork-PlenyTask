//
//  FeedView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/14/23.
//

import SwiftUI

struct FeedView: View {
    
    // MARK: POST DETAILS
    @State private var userPic = "Ahmed saad"
    @State private var username = "Ahmed saad"
    @State private var publishedDate = Date(timeIntervalSinceReferenceDate: 2312)
    @State private var postText = "Craving delicious Food ? Try our new dish - a savory mix of roasted vegetables and quinoa, topped with a zesty garlic. Yum!"
    @State private var image: String = "Image1"
    @StateObject var feedData = FeedViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                HStack(alignment: .top, spacing: 10) {
                    
                    Button(action: {
                        withAnimation(.easeInOut) {
                            feedData.selectedCriteria = 0
                            feedData.showImageViewer.toggle()
                        }
                    }, label: {
                        Image(userPic)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    })
                    
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(username)
                            .font(.system(size: 17))
                            .fontWeight(.medium)
                        Text(setupDate())
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    .overlay(alignment: .topTrailing, content: {
                        Menu(content: {
                            
                        }, label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 20))
                                .foregroundColor(Color(.darkGray))
                                .padding(8)
                                .containerShape(Rectangle())
                        })
                    })
                }
                
                VStack(alignment: .center) {
                    Text(postText)
                        .textSelection(.enabled)
//                        .padding(.vertical, 0)
                    
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 5), count: 2)
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 7, content: {
                        ForEach(feedData.feedImages.indices, id: \.self) { index in
                            GridImageView(index: index)
                        }
                    })
                }
            }
        }
        .padding(.all, 10)
        .overlay(content: {
            // imageViewer
            ZStack {
                if feedData.showImageViewer {
                     ImageView()
                }
            }
        })
        .environmentObject(feedData)
    }
    
    private func setupDate() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let stringDate = formatter.localizedString(for: publishedDate, relativeTo: Date())
        return stringDate
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
