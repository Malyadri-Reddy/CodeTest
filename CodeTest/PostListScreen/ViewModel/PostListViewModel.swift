//
//  PostListViewModel.swift
//  CodeTest
//
//  Created by Malyadri on 18/08/25.
//

import Foundation

@MainActor
class PostListViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var errorMessage: String?

    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    func fetchPosts() async {
        do {
            let posts = try await service.fetchPosts()
            self.posts = posts
        } catch {
            self.errorMessage = "Error: \(error)"
        }
    }
}
