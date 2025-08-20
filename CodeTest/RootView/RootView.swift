//
//  RootView.swift
//  CodeTest
//
//  Created by Malyadri on 20/08/25.
//

import SwiftUI
import Foundation

struct RootView: View {
    @StateObject private var loginVM = LoginViewModel()

    var body: some View {
//        NavigationStack {
//            if loginVM.isLoggedIn {
//                PostListView()
//            } else {
//                LoginView()
//            }
//        }
        NavigationStack {
                    if loginVM.isLoggedIn {
                        PostListView()
                            .navigationTitle("Posts")
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button("Logout") {
                                        loginVM.logout()
                                    }
                                }
                            }
                    } else {
                        LoginView()
                    }
                    
                }
        .onAppear {
            loginVM.autoLogin()
        }
    }
}
