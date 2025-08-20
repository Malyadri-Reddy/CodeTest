//
//  PostTests.swift
//  CodeTest
//
//  Created by Malyadri on 20/08/25.
//

import XCTest
@testable import CodeTest

final class PostTests: XCTestCase {
    func testPostDecodingSuccess() throws {
        let json = """
        {
            "id": 1,
            "title": "Test Title",
            "body": "Test Body"
        }
        """.data(using: .utf8)!

        let post = try JSONDecoder().decode(Post.self, from: json)
        XCTAssertEqual(post.id, 1)
        XCTAssertEqual(post.title, "Test Title")
        XCTAssertEqual(post.body, "Test Body")
    }

    func testPostDecodingFailure() {
        let invalidJson = """
        {
            "identifier": 1,
            "heading": "Wrong Keys"
        }
        """.data(using: .utf8)!

        XCTAssertThrowsError(try JSONDecoder().decode(Post.self, from: invalidJson))
    }
}
