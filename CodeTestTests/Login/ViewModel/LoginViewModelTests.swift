//
//  LoginViewModelTests.swift
//  CodeTest
//
//  Created by Malyadri on 20/08/25.
//

import XCTest
@testable import CodeTest

final class LoginViewModelTests: XCTestCase {
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
}
