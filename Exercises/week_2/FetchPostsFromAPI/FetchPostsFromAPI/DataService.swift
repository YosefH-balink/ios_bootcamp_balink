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
// fetch posts from api 
    static func fetchPosts(onFetch: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            //returns server error
            if let error {
                onFetch(.failure(error))
                return
            }
            guard let data else {
                //need to add error type
                onFetch(.failure(NSError()))
                return
            }
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                onFetch(.success(posts))
            } catch {
                //need to add error type
                onFetch(.failure(NSError()))
            }
        }
        task.resume()
    }
}
