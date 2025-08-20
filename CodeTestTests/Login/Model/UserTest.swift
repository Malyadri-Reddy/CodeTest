//
//  UserTest.swift
//  CodeTest
//
//  Created by Malyadri on 20/08/25.
//

import XCTest
@testable import CodeTest

final class UserTests: XCTestCase {
    func testUserInitialization() {
        let user = User(username: "admin", password: "1234")
        XCTAssertEqual(user.username, "admin")
        XCTAssertEqual(user.password, "1234")
    }
}
