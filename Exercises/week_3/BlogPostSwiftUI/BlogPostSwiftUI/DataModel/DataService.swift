//
//  DataService.swift
//  MyFirstSwiftUI
//
//  Created by Balink on 27/06/2023.
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
    
    static func fetcComments(postId: Int) -> AnyPublisher<[Comments], Error>{
        let url = URL(string:"https://jsonplaceholder.typicode.com/comments?postId=\(postId)")!
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
            .decode(type: [Comments].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}



