//
//  Post.swift
//  CodeTest
//
//  Created by Malyadri on 18/08/25.
//

struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
}
