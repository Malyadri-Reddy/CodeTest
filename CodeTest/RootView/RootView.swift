//
//  RootView.swift
//  CodeTest
//
//  Created by Malyadri on 20/08/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var loginVM = LoginViewModel()

    var body: some View {
        NavigationStack {
            if loginVM.isLoggedIn {
                PostListView()
            } else {
                LoginView()
            }
        }
    }
}
