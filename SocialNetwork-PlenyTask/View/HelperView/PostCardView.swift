//
//  PostCardView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/14/23.
//

import SwiftUI

struct PostCardView: View {
    
    // MARK: POST DETAILS
    @State private var publishedDate = Date(timeIntervalSinceReferenceDate: 2312)
    @EnvironmentObject var postsViewModel: PostsViewModel

    // cardViewPro
    var post: Post
    var staticPost: StaticPostData
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            // User info
            HStack(alignment: .top, spacing: 10) {
                Button(action: { // selectable profile picture
                    withAnimation(.easeInOut) {
                        postsViewModel.selectedCriteria = 0
                        postsViewModel.showImageViewer.toggle()
                    }
                }, label: {
                    Image(staticPost.profilePic)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                })
                // name and date ago
                VStack(alignment: .leading, spacing: 2) {
                    Text(staticPost.username)
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                    Text(setupDate())
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                Spacer()
                // post menu button "right side"
                    .overlay(alignment: .topTrailing, content: {
                        Menu(content: {
                            // Menu action
                        }, label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 20))
                                .foregroundColor(Color(.darkGray))
                                .padding(8)
                                .containerShape(Rectangle())
                        })
                    })
            }
            // post contents (body and images)
            VStack(alignment: .leading) {
                Text(post.body)
                    .textSelection(.enabled)
                
                let columns = Array(repeating: GridItem(.flexible(), spacing: 5), count: 2)
                LazyVGrid(columns: columns, alignment: .leading, spacing: 7, content: {
                    ForEach(staticPost.postImages.indices, id: \.self) { index in
                        GridImageView(index: index, staticPost: staticPost)
                    }
                })
            }
        }
        .padding(.all, 10)
    }
    
    // MARK: Setup date 'ago'
    private func setupDate() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let stringDate = formatter.localizedString(for: publishedDate, relativeTo: Date())
        return stringDate
    }
}
