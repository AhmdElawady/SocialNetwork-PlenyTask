//
//  PostsViewModel.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/15/23.
//

import SwiftUI


struct StaticPostData {
    var username: String
    var profilePic: String
    var postImages: [String]
}


class PostsViewModel: ObservableObject {
    
    @Published var postData: [StaticPostData] = [
    StaticPostData(username: "Neama Ahmed", profilePic: "profile2", postImages: ["Image2", "Image5", "Image7"]),
    StaticPostData(username: "Ahmed Saad", profilePic: "profile1", postImages: ["Image4", "Image1", "Image6", "Image4", "Image3", "Image1"]),
    StaticPostData(username: "KFC", profilePic: "profile3", postImages: ["Image3"])
    ].shuffled()
    
    
//    @Published var userProfilePic: [String] = ["profile1", "profile2", "profile3"].shuffled()
//    @Published var feedImages: [String] = ["Image1", "Image2", "Image3", "Image4", "Image5", "Image6", "Image7", "Image8"].shuffled()
    
    @Published var showImageViewer = false
    @Published var selectedImageID: String = ""
    @Published var selectedCriteria: Int = 0
    
    func getPosts(completion: @escaping ([Post], Error?) -> ()) {
        PostService().getPosts(completion: completion)
    }
}


