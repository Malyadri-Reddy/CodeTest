//
//  PostDetailView.swift
//  CodeTest
//
//  Created by Malyadri on 20/08/25.
//

import SwiftUI

struct PostDetailView: View {
    @ObservedObject var vm: PostDetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(vm.post.title)
                .font(.title)
                .bold()
            Text(vm.post.body)
                .font(.body)
        }
        .padding()
        .navigationTitle("Details")
    }
}
