//
//  PostDetailViewModelTests.swift
//  CodeTest
//
//  Created by Malyadri on 20/08/25.
//

import XCTest
@testable import CodeTest

final class PostDetailViewModelTests: XCTestCase {
    func testPostDetailInitialization() {
        let post = Post(id: 1, title: "Sample Title", body: "Sample Body")
        let vm = PostDetailViewModel(post: post)
        XCTAssertEqual(vm.post.title, "Sample Title")
        XCTAssertEqual(vm.post.body, "Sample Body")
    }
}
