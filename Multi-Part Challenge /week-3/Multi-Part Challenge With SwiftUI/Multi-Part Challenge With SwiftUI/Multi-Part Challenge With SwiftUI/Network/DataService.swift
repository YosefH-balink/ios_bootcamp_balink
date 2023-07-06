//
//  DataService.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 29/06/2023.
//

import Foundation
import Combine

enum RequestType: String {
case register = "register"
case login = "login"
}


class DataService {
    
    static var shared = DataService()
    
    func getToken(firstname: String? = nil, lastname: String? = nil, username: String, password: String, requestType: RequestType) -> AnyPublisher<String, Error> {
       // let urlEndpoint = requestType == .register ? "register" : "login"
        guard let url = URL(string: "https://balink.onlink.dev/users/\(requestType.rawValue)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        let body = RegisterBody(firstname: firstname, lastname: lastname, username: username, password: password)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    throw NSError(domain: errorResponse.code, code: errorResponse.status, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])
                }
                return data
            }
            .decode(type: AccessToken.self, decoder: JSONDecoder())
            .map { accessToken -> String in
                guard let token = accessToken.token else {
                    print("The access token is not fetched.")
                    return ""
                }
                return token
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getCategories() -> AnyPublisher<[String], Error> {
        let token = UserDefaults.standard.string(forKey: "accessToken")
        guard let url = URL(string: "https://balink.onlink.dev/categories") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token ?? "", forHTTPHeaderField: "Authorization")
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    throw NSError(domain: errorResponse.code, code: errorResponse.status, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])
                }
                return data
            }
            .decode(type: [String].self, decoder: JSONDecoder())
            .map { categories -> [String] in
                return categories
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    func getProductsForCategorie(categorie: String) -> AnyPublisher<[Product], Error> {
        let token = UserDefaults.standard.string(forKey: "accessToken")
        guard let url = URL(string: "https://balink.onlink.dev/categories/\(categorie)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token ?? "", forHTTPHeaderField: "Authorization")
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    throw NSError(domain: errorResponse.code, code: errorResponse.status, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])
                }
                return data
            }
            .decode(type: [Product].self, decoder: JSONDecoder())
            .map { products -> [Product] in
                return products
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
   
    func getFavoritesProducts() -> AnyPublisher<[Product], Error> {
        let token = UserDefaults.standard.string(forKey: "accessToken")
        guard let url = URL(string: "https://balink.onlink.dev/products/ids") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token ?? "", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["products": UserDefaults.standard.array(forKey: "favoriteProducts")as? [Int] ?? []])
        print("request.httpBody----->",   request.httpBody! )
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    throw NSError(domain: errorResponse.code, code: errorResponse.status, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])
                }
                return data
            }
            .decode(type: [Product].self, decoder: JSONDecoder())
            .map { products -> [Product] in
                return products
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getAllProducts() -> AnyPublisher<[Product], Error> {
        let token = UserDefaults.standard.string(forKey: "accessToken")
        guard let url = URL(string: "https://balink.onlink.dev/products") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(token ?? "", forHTTPHeaderField: "Authorization")
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    throw NSError(domain: errorResponse.code, code: errorResponse.status, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])
                }
                return data
            }
            .decode(type: [Product].self, decoder: JSONDecoder())
            .map { products -> [Product] in
                return products
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}


