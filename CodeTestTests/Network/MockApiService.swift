//
//  MockApiService.swift
//  CodeTest
//
//  Created by Malyadri on 18/08/25.
//

import XCTest
@testable import CodeTest

class MockApiService:APIServiceProtocol {
    
//    var shouldFailFetchPosts: Bool = false
//    
//    func fetchPosts() async throws -> [Post] {
//        
//        if shouldFailFetchPosts {
//            throw URLError(.badServerResponse)
//        }
//        
//        return [Post(id: 1, title: "Test Title", body: "Test Body")]
//    }
    
    private let session: URLSession

       init() {
           let config = URLSessionConfiguration.ephemeral
           config.protocolClasses = [MockURLProtocol.self]
           session = URLSession(configuration: config)
       }

       func fetchPosts() async throws -> [Post] {
           guard let url = URLBuilder.buildURL(path: URLConstants.Endpoint.posts) else {
               throw APIError.invalidURL
           }

           let (data, response) = try await session.data(from: url)

           guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
               throw APIError.serverError
           }

           return try JSONDecoder().decode([Post].self, from: data)
       }
    
}

