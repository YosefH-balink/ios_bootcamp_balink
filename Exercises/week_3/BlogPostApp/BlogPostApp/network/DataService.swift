//
//  DataService.swift
//  BlogPostApp
//
//  Created by Balink on 25/06/2023.
//


import Foundation
import Combine

enum NetworkError: Error{
    case badUrl
}

class DataServiceWithCombine{

    static func fetcPost() -> AnyPublisher<[Post], Error>{        
        let url = URL(string:"https://jsonplaceholder.typicode.com/posts")!
//        else {
//            return Just(NetworkError.badUrl).eraseToAnyPublisher()
//        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data  in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 &&  response.statusCode < 300  else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .mapError { _ in NetworkError.badUrl }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}



//class DataServiceWithAsyncAwait {
//    static let shared = DataServiceWithAsyncAwait()
//
//    func fetchPosts() async throws -> [Post] {
//        guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts") else {
//            throw ServerError(message: "Invalid URL")
//        }
//        let request = URLRequest(url: url)
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            let posts = try JSONDecoder().decode([Post].self, from: data)
//            return posts
//        } catch {
//            throw ServerError(message: error.localizedDescription)
//        }
//    }
//}
