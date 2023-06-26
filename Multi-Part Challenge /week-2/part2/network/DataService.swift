//
//  DataService.swift
//  FetchPostsFromAPI
//
//  Created by Balink on 19/06/2023.
//

import Foundation

class DataService {
    
    static let shared = DataService()
    
    var token: String?

    func register(firstname: String, lastname: String, username: String, password: String) async throws -> String {
        guard let url = URL(string: "https://balink.onlink.dev/register") else {
            throw ServerError(message: "Invalid URL")
        }
        
        let body = registerBody(firstname: firstname, lastname: lastname, username: username, password: password)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let token = String(data: data, encoding: .utf8) {
                return token
            } else {
                throw ServerError(message: "Invalid response")
            }
        } catch {
            throw ServerError(message: error.localizedDescription)
        }
    }

    
    func getProducts(token: String) async throws -> [Product] {
        guard let url = URL(string: "https://balink.onlink.dev/products") else {
            throw ServerError(message: "Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let products = try JSONDecoder().decode([Product].self, from: data)
            return products
        } catch {
            throw ServerError(message: error.localizedDescription)
        }
    }

}
