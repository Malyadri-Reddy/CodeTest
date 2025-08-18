//
//  MockApiService.swift
//  CodeTest
//
//  Created by Goutham S on 18/08/25.
//

import XCTest
@testable import CodeTest

class MockApiService:APIServiceProtocol {
    
    var shouldFailFetchPosts: Bool = false
    
    func fetchPosts() async throws -> [Post] {
        
        if shouldFailFetchPosts {
            throw URLError(.badServerResponse)
        }
        
        return [Post(id: 1, title: "Test Title", body: "Test Body")]
    }
    
}

