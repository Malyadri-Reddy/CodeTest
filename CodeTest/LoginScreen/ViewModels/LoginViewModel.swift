//
//  LoginViewModel.swift
//  CodeTest
//
//  Created by Malyadri on 20/08/25.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    //@Published var isLoggedIn = false
    @Published var errorMessage: String?
    private let service = "com.myapp.auth"
    private let account = "userCredentials"

    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    func login() {
        // should be call login api, for now just checking the const credentials
        if username == "admin" && password == "1234" {
            errorMessage = nil
            isLoggedIn = true
            saveCredentials(username: username, password: password)
        } else {
            isLoggedIn = false
            errorMessage = "Invalid credentials"
        }
    }
    
    func autoLogin() {
            if let data = KeychainHelper.shared.read(service: service, account: account),
               let creds = try? JSONDecoder().decode(User.self, from: data) {
                username = creds.username
                password = creds.password
                isLoggedIn = true
            }
        }

    func logout() {
        KeychainHelper.shared.delete(service: service, account: account)
        isLoggedIn = false
        username = ""
        password = ""
    }
    
    private func saveCredentials(username: String, password: String) {
           let creds = User(username: username, password: password)
           if let data = try? JSONEncoder().encode(creds) {
               KeychainHelper.shared.save(data, service: service, account: account)
           }
       }
}
