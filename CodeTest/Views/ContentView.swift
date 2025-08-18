//
//  ContentView.swift
//  CodeTest
//
//  Created by Goutham S on 18/08/25.
//

import SwiftUI

@MainActor
struct ContentView: View {
    
    @StateObject private var viewModel = PostListViewModel()
    
    var body: some View {
        
        NavigationView {
            Group {
                
                if viewModel.isLoading {
                    ProgressView("loading ...")
                }
                else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                }
                else {
                    List(viewModel.posts) { post in
                        Text(post.title)
                        Text(post.body)
                    }
                }
            }
        }
        .navigationTitle("Posts")
        .task {
            await viewModel.fetchPosts()
        }
    }
}

#Preview {
    ContentView()
}
