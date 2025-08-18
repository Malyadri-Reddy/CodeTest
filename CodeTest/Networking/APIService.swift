//
//  APIService.swift
//  CodeTest
//
//  Created by Goutham S on 18/08/25.
//

import Foundation

class APIService: APIServiceProtocol {
    func fetchPosts() async throws -> [Post] {
        
        guard let url = URLBuilder.buildURL(path: URLConstants.Endpoint.posts) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Post].self, from: data)
    }
    
}
