//
//  APIServiceProtocol.swift
//  CodeTest
//
//  Created by Malyadri on 18/08/25.
//

protocol APIServiceProtocol {
    func fetchPosts() async throws -> [Post]
}


enum APIError: Error {
    case invalidURL
    case decodingError
    case serverError
}
