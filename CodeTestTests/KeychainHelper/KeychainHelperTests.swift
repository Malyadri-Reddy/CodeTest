//
//  KeychainHelperTests.swift
//  CodeTest
//
//  Created by Malyadri on 20/08/25.
//

import XCTest
@testable import CodeTest

final class KeychainHelperTests: XCTestCase {

    let service = "com.myapp.test"
    let account = "testUser"

    func testSaveAndReadCredentials() {
        let data = "password123".data(using: .utf8)!
        KeychainHelper.shared.save(data, service: service, account: account)

        let retrieved = KeychainHelper.shared.read(service: service, account: account)
        XCTAssertNotNil(retrieved)
        XCTAssertEqual(String(data: retrieved!, encoding: .utf8), "password123")
    }

    func testDeleteCredentials() {
        let data = "tempPassword".data(using: .utf8)!
        KeychainHelper.shared.save(data, service: service, account: account)

        KeychainHelper.shared.delete(service: service, account: account)
        let retrieved = KeychainHelper.shared.read(service: service, account: account)

        XCTAssertNil(retrieved, "Credentials should be deleted")
    }
}
