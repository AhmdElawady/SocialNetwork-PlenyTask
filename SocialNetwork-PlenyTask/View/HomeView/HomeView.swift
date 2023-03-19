//
//  HomeView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/19/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = PostsViewModel()
    var body: some View {
        
        TabView {
            PostsView()
                .tabItem {
                    Image("home")
                }
                .environmentObject(homeViewModel)
            ShopView()
                .tabItem {
                    Image("shop")
                }
            OffersView()
                .tabItem {
                    Image("offers")
                }
            GalleryView()
                .tabItem {
                    Image("gallery")
                }
            ProfileView()
                .tabItem {
                    Image("profile")
                }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
