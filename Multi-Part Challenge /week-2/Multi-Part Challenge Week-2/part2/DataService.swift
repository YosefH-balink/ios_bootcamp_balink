//
//  DataService.swift
//  FetchPostsFromAPI
//
//  Created by Balink on 19/06/2023.
//

import Foundation

struct registerBody: Codable {
    let firstname: String
    let lastname: String
    let username: String
    let password: String
}

struct registerResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}


class DataService {
    
   static let shared = DataService()

//   let json = {
//       "firstname": "name",
//    "lastname": "name",
//    "username": "email@email.com",
//    "password": "asdf"
//    }

    
    func register(firstname:String, lastname:String, username:String, password:String) async throws -> Void {
        guard let url = URL(string:"https://balink.onlink.dev/register") else {fatalError("Missing URL")}
        var request = URLRequest(url: url)
        let body = registerBody(firstname: firstname, lastname: lastname, username: username, password: password)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request { (data, response, error) in
            
        }
        
//        let (data, response) = try await URLSession.shared.data(for: request)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data")}
//        let token = try JSONDecoder().
//        return token
//    }
    
    
//    func fetchPosts() async throws -> [Post] {
//        guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts") else {fatalError("Missing URL")}
//        let request = URLRequest(url: url)
//        let (data, response) = try await URLSession.shared.data(for: request)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data")}
//        let posts = try JSONDecoder().decode([Post].self, from: data)
//        return posts
//    }
      
}
