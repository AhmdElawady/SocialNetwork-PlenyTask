//
//  LoginView.swift
//  SocialNetwork-PlenyTask
//
//  Created by Awady on 3/14/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var loginViewModel = LoginViewModel()
    
    // MARK: USER DETAILS
//    @State private var username = ""
//    @State private var password = ""
    
    @State private var visible = false
    @State private var isLoading = false
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 40) { // spacing top content with login button
                
                VStack(spacing: 24) { // spacing top content
                    Image("loginImage")
                        .resizable()
                        .aspectRatio(UIImage(named: "loginImage")!.size, contentMode: .fill)
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 440)
                    
                    
                    Text("Welcome")
                        .font(.system(size: 20, weight: .bold))
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
//                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    // MARK: Username TextField
                    VStack(alignment: .leading, spacing: 6) {
                        Text("User Name")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                        
                        TextField("Enter your username", text: $loginViewModel.username)
                            .frame(height: 20)
                            .font(.system(size: 17))
                            .padding()
                            .frame(height: 42)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color(.black).opacity(0.1) ,lineWidth: 2))
                    }
                    .padding(.horizontal)
                    
                    // MARK: Password TextField
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                        
                        HStack(spacing: 15) {
                            if self.visible {
                                TextField("Enter your password", text: $loginViewModel.password)
                                    .padding()
                            } else {
                                SecureField("Enter your password", text: $loginViewModel.password)
                                    .padding()
                            }
                            
                            Button(action:  {
                                self.visible.toggle()
                            }) {
                                Image.init(systemName: self.visible ? "eye.slash.fill" : "eye.fill").resizable()
                                    .foregroundColor(Color(.gray))
                                    .frame(width: 15, height: 12)
                                    .padding()
                            }
                        }
                        .font(.system(size: 17))
                        .frame(height: 42)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color(.black).opacity(0.1) ,lineWidth: 2))
                    }
                    .padding(.horizontal)
                }
                
                
                // MARK: Login button
                Button(action: signInUser) {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .bold))
                        .frame(height: 42)
                        .frame(width: UIScreen.main.bounds.width - 30)
                }
                .background(.blue)
                .cornerRadius(32)
                .padding(.bottom, 53)
            }
            .overlay(content: {
                LoadingView(show: $isLoading)
            })
        }
    }
    
    func signInUser() {
        isLoading = true
        loginViewModel.login()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
