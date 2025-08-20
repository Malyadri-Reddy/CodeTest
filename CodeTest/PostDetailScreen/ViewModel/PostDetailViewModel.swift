//
//  PostDetailViewModel.swift
//  CodeTest
//
//  Created by Malyadri on 20/08/25.
//

import Foundation

class PostDetailViewModel: ObservableObject {
    @Published var post: Post

    init(post: Post) {
        self.post = post
    }
}
