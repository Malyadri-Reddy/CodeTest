//
//  APIServiceProtocol.swift
//  CodeTest
//
//  Created by Goutham S on 18/08/25.
//

protocol APIServiceProtocol {
    
    func fetchPosts() async throws -> [Post]
    
}
