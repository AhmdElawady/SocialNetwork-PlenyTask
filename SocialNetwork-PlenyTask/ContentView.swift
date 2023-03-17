//
//  ContentView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/14/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        if logStatus {
            SearchPostsView()
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
