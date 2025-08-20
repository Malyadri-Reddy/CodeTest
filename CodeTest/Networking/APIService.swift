//
//  APIService.swift
//  CodeTest
//
//  Created by Malyadri on 18/08/25.
//

import Foundation

class APIService: APIServiceProtocol {
    
    func fetchPosts() async throws -> [Post] {
        
        guard let url = URLBuilder.buildURL(path: URLConstants.Endpoint.posts) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.serverError
        }
        
        do {
            return try JSONDecoder().decode([Post].self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
}
