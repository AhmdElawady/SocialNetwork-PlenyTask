//
//  FeedView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/14/23.
//

import SwiftUI

struct PostCardView: View {
    
    // MARK: POST DETAILS
    @State private var userPic = "profile1"
    @State private var username = "Ahmed saad"
    @State private var publishedDate = Date(timeIntervalSinceReferenceDate: 2312)
    @State private var postText = "Craving delicious Food ? Try our new dish - a savory mix of roasted vegetables and quinoa, topped with a zesty garlic. Yum!"
    @State private var image: String = "Image1"
    @StateObject var feedData = FeedViewModel()
    @State var posts: [Post] = []
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
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
                    
                    VStack(alignment: .leading) {
                        Text(postText)
                            .textSelection(.enabled)
                        
                        let columns = Array(repeating: GridItem(.flexible(), spacing: 5), count: 2)
                        LazyVGrid(columns: columns, alignment: .leading, spacing: 7, content: {
                            ForEach(feedData.feedImages.indices, id: \.self) { index in
                                GridImageView(index: index)
                            }
                        })
                    }
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // MARK: LOGO IMAGE NEED RESIZE ADJUSTMENT
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
            
            .overlay(content: {
                LoadingView(show: $isLoading)
            })
        }
    }
  
    
    private func setupDate() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let stringDate = formatter.localizedString(for: publishedDate, relativeTo: Date())
        return stringDate
    }
    
    func getPosts() { // get all posts
        isLoading = true
        feedData.getPosts { posts, error in
            if error == nil {
                self.posts = posts
                print(posts)
            }
            isLoading = false
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
