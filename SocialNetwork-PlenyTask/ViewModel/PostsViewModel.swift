//
//  PostsViewModel.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/15/23.
//

import SwiftUI
import Combine


struct StaticPostData {
    var username: String
    var profilePic: String
    var postImages: [String]
}

//var postData: [StaticPostData] = [[StaticPostData]](repeating:
//[StaticPostData(username: "Neama Ahmed", profilePic: "profile2", postImages: ["Image2", "Image5", "Image7", "Image1", "Image4"]),
//StaticPostData(username: "Ahmed Saad", profilePic: "profile1", postImages: ["Image1", "Image6", "Image4"]),
//StaticPostData(username: "KFC", profilePic: "profile3", postImages: ["Image1"])],
//count: 50).flatMap{$0}

class PostsViewModel: ObservableObject {

    var localData = StaticPostData(username: "Ahmed Saad", profilePic: "profile1", postImages: ["Image2", "Image5", "Image7", "Image1", "Image4"])
    
    @Published var posts: [Post] = []
    @Published var skipCount = 0
    
    @Published var showImageViewer = false
    @Published var selectedImageID: String = ""
    @Published var selectedCriteria: Int = 0
    
    // search posts
    var searchCancelable: AnyCancellable? = nil
    @Published var searchQuery = ""
    @Published var searchedPosts: [Post] = []
    @Published var searchSkipCount = 0
    @Published var isFetching: Bool = false
    
    init() {
        searchCancelable = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == "" {
                    
                } else {
                    self.fetchSearchedPosts()
                }
            })
    }
    
    func fetchPosts() {
        let limit = 10
        Services.shared.fetchPosts(limit: limit, skip: self.skipCount) { posts, error in
            if error != nil && posts == nil { print("Fetch posts error \(String(describing: error))") }
            DispatchQueue.main.async {
                self.posts.append(contentsOf: posts?.posts ?? [])
                self.skipCount = posts?.skip ?? 0
            }
        }
    }
    
    func fetchSearchedPosts() {
        isFetching = true
        Services.shared.fetchSearchedPosts(limit: 5, skip: searchSkipCount, searchTerm: searchQuery) { posts, error in
            if error != nil && posts == nil { print("Fetch posts error \(String(describing: error))") }
            DispatchQueue.main.async {
                self.searchedPosts = posts?.posts ?? []
                self.searchSkipCount = posts?.skip ?? 0
                self.isFetching = false
            }
        }
    }
}


