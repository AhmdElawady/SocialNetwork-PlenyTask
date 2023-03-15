//
//  FeedViewModel.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/15/23.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    
    @Published var userProfilePic: String = "Ahmed saad"
    
    @Published var feedImages: [String] = ["Image1", "Image3", "Image2"]
    
    @Published var showImageViewer = false
    @Published var selectedImageID: String = ""
    @Published var selectedCriteria: Int = 0
}


