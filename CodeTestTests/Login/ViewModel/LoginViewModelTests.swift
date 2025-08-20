//
//  LoginViewModelTests.swift
//  CodeTest
//
//  Created by Malyadri on 20/08/25.
//

import XCTest
@testable import CodeTest

final class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    let service = "com.myapp.auth"
    let account = "userCredentials"

    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
        // Clear stored credentials before each test
        KeychainHelper.shared.delete(service: service, account: account)
    }
        

    override func tearDown() {
        KeychainHelper.shared.delete(service: service, account: account)
        viewModel = nil
        super.tearDown()
    }
        
    
    func testLoginSuccess() {
        let vm = LoginViewModel()
        vm.username = "admin"
        vm.password = "1234"
        vm.login()
        XCTAssertTrue(vm.isLoggedIn)
        XCTAssertNil(vm.errorMessage)
    }

    func testLoginFailure() {
        let vm = LoginViewModel()
        vm.username = "wrong"
        vm.password = "user"
        vm.login()
        XCTAssertFalse(vm.isLoggedIn)
        XCTAssertEqual(vm.errorMessage, "Invalid credentials")
    }
    
    func testLoginSavesCredentials() {
            viewModel.username = "admin"
            viewModel.password = "1234"
            viewModel.login()

            XCTAssertTrue(viewModel.isLoggedIn)

            let stored = KeychainHelper.shared.read(service: service, account: account)
            XCTAssertNotNil(stored, "Credentials should be saved in Keychain")
        }

        func testAutoLoginRestoresSession() {
            // Save credentials manually
            let creds = User(username: "admin", password: "1234")
            let data = try! JSONEncoder().encode(creds)
            KeychainHelper.shared.save(data, service: service, account: account)

            viewModel.autoLogin()

            XCTAssertTrue(viewModel.isLoggedIn)
            XCTAssertEqual(viewModel.username, "admin")
            XCTAssertEqual(viewModel.password, "1234")
        }

        func testLogoutClearsSessionAndKeychain() {
            viewModel.username = "admin"
            viewModel.password = "1234"
            viewModel.login()

            viewModel.logout()

            XCTAssertFalse(viewModel.isLoggedIn)
            XCTAssertEqual(viewModel.username, "")
            XCTAssertEqual(viewModel.password, "")

            let stored = KeychainHelper.shared.read(service: service, account: account)
            XCTAssertNil(stored, "Keychain should be cleared on logout")
        }
}
