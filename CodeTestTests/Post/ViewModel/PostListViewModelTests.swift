//
//  PostListViewModelTests.swift
//  CodeTest
//
//  Created by Malyadri on 20/08/25.
//

import XCTest
@testable import CodeTest

final class PostListViewModelTests: XCTestCase {
    func testFetchPostsSuccess() async {
        let mockService = MockApiService()
        MockURLProtocol.requestHandler = { request in
            let posts = [Post(id: 1, title: "Mock Title", body: "Mock Body")]
            let data = try JSONEncoder().encode(posts)
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, data)
        }

        let vm = await PostListViewModel(service: mockService)
        await vm.fetchPosts()

        await MainActor.run {
            XCTAssertEqual(vm.posts.count, 1)
            XCTAssertEqual(vm.posts.first?.title, "Mock Title")
            XCTAssertNil(vm.errorMessage)
        }
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

        let vm = await PostListViewModel(service: mockService)
        await vm.fetchPosts()

        await MainActor.run {
            XCTAssertTrue(vm.posts.isEmpty)
            XCTAssertNotNil(vm.errorMessage)
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

        let vm = await PostListViewModel(service: mockService)
        await vm.fetchPosts()

        await MainActor.run {
            XCTAssertTrue(vm.posts.isEmpty)
            XCTAssertNotNil(vm.errorMessage)
        }
    }
}
