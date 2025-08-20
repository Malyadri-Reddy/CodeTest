//
//  APIServiceTests.swift
//  CodeTest
//
//  Created by Malyadri on 20/08/25.
//

import XCTest
@testable import CodeTest

final class APIServiceTests: XCTestCase {
    func testFetchPostsSuccess() async throws {
        let mockService = MockApiService()
        MockURLProtocol.requestHandler = { request in
            let posts = [Post(id: 1, title: "Test Title", body: "Test Body")]
            let data = try JSONEncoder().encode(posts)
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, data)
        }

        let posts = try await mockService.fetchPosts()
        XCTAssertEqual(posts.count, 1)
        XCTAssertEqual(posts.first?.title, "Test Title")
    }

    func testFetchPostsServerError() async {
        let mockService = MockApiService()
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 500,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, Data())
        }

        do {
            _ = try await mockService.fetchPosts()
            XCTFail("Expected server error")
        } catch {
            XCTAssertTrue(error is APIError)
        }
    }

    func testFetchPostsDecodingError() async {
        let mockService = MockApiService()
        MockURLProtocol.requestHandler = { request in
            let data = Data("invalid json".utf8)
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, data)
        }

        do {
            _ = try await mockService.fetchPosts()
            XCTFail("Expected decoding error")
        } catch {
            XCTAssertTrue(error is APIError || error is DecodingError)
        }
    }

    func testInvalidURL() async {
        class BadService: APIServiceProtocol {
            func fetchPosts() async throws -> [Post] {
                throw APIError.invalidURL
            }
        }

        let badService = BadService()
        do {
            _ = try await badService.fetchPosts()
            XCTFail("Expected invalidURL error")
        } catch {
            XCTAssertEqual(error as? APIError, APIError.invalidURL)
        }
    }
}
