//
//  URLConstants.swift
//  CodeTest
//
//  Created by Goutham S on 18/08/25.
//

import Foundation

enum URLConstants {
    static let baseURLString = "https://jsonplaceholder.typicode.com"
    
    enum Endpoint {
     static let posts = "/posts"
    }
}

enum URLBuilder {

    static func buildURL(path: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        
        var components = URLComponents(string: URLConstants.baseURLString)
        components?.path = path
        components?.queryItems = queryItems
        
        guard let url = components?.url else { fatalError("Invalid URL") }
        return url
        
    }
}
