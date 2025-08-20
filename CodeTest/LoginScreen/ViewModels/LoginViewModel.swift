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

    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    func login() {
        // should be call login api, for now just checking the const credentials
        if username == "admin" && password == "1234" {
            errorMessage = nil
            isLoggedIn = true
        } else {
            isLoggedIn = false
            errorMessage = "Invalid credentials"
        }
    }
}
