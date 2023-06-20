//
//  DataService.swift
//  FetchPostsFromAPI
//
//  Created by Balink on 19/06/2023.
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DataService {
    
   static let shared = DataService()
// fetch posts from api 
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts") else {fatalError("Missing URL")}
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data")}
        let posts = try JSONDecoder().decode([Post].self, from: data)
        return posts
    }
      
}
