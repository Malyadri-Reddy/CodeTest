//
//  LoginView.swift
//  CodeTest
//
//  Created by Malyadri on 20/08/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var vm = LoginViewModel()

    var body: some View {
            NavigationStack {
                VStack(spacing: 16) {
                    TextField("Username", text: $vm.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    SecureField("Password", text: $vm.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button("Login") {
                        vm.login()
                    }
                    .buttonStyle(.borderedProminent)

                    if let error = vm.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    }

                    // NavigationLink must be inside NavigationStack
//                    NavigationLink(destination: PostListView(), isActive: $vm.isLoggedIn) {
//                        EmptyView()
//                    }
                }
                .padding()
                .navigationTitle("Login")
                .navigationDestination(isPresented: $vm.isLoggedIn) {
                    PostListView()
                        .navigationBarBackButtonHidden(true)
                }

            }
        }
}
