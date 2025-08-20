//
//  ContentView.swift
//  CodeTest
//
//  Created by Goutham S on 18/08/25.
//

import SwiftUI

@MainActor
struct PostListView: View {
    @StateObject private var vm = PostListViewModel()

    var body: some View {
        List(vm.posts) { post in
            NavigationLink(destination: PostDetailView(vm: PostDetailViewModel(post: post))) {
                Text(post.title)
                    .font(.headline)
            }
        }
        .task {
            await vm.fetchPosts()
        }
        .navigationTitle("Posts")
    }
}

#Preview {
    PostListView()
}
