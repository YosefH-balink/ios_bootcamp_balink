//
//  DataService.swift
//  BlogPostApp
//
//  Created by Balink on 25/06/2023.
//


import Foundation

class DataService {
    
    static let shared = DataService()
    // fetch posts from api
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts") else {
            throw ServerError(message: "Invalid URL")
        }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let posts = try JSONDecoder().decode([Post].self, from: data)
            print(posts)
                return posts
        } catch {
            throw ServerError(message: error.localizedDescription)
        }
    }
    
}
