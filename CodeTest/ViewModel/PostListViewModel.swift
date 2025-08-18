//
//  PostListViewModel.swift
//  CodeTest
//
//  Created by Goutham S on 18/08/25.
//

import Foundation

class PostListViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let apiService: APIServiceProtocol
    init(service: APIServiceProtocol = APIService()) {
        self.apiService = service
    }
    
    func fetchPosts() async {
        isLoading = true
        errorMessage = nil
        do {
            let posts = try await apiService.fetchPosts()
            self.posts = posts
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
}
