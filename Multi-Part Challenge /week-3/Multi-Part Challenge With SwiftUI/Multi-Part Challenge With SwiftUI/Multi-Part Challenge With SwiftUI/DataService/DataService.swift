//
//  DataService.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 29/06/2023.
//

import Foundation
import Combine

class DataService {
    static var shared = DataService()
    
    func registerGetToken(firstname: String, lastname: String, username: String, password: String) -> AnyPublisher<String, Error> {
        guard let url = URL(string: "https://balink.onlink.dev/users/register") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        let body = registerBody(firstname: firstname, lastname: lastname, username: username, password: password)
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
                print("accessToken---->", accessToken)
                guard let token = accessToken.token else {
                    print("The access token is not fetched.")
                    return ""
                }
                return token
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func loginGetToken(username: String, password: String) -> AnyPublisher<String, Error> {
        guard let url = URL(string: "https://balink.onlink.dev/users/login") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        let body = loginBody(username: username, password: password)
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
    
    func getCategories(token: String) -> AnyPublisher<[String], Error> {
        guard let url = URL(string: "https://balink.onlink.dev/categories") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
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
    
    
    func getProductsForCategorie(token: String, categorie: String) -> AnyPublisher<[Product], Error> {
        guard let url = URL(string: "https://balink.onlink.dev/categories/\(categorie)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
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
   
    func getFavoriteProducts(token: String, favorites: [String]) -> AnyPublisher<[Product], Error> {
        guard let url = URL(string: "https://balink.onlink.dev/favorites") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        let body = favoritesBody(products: UserDefaults.standard.array(forKey: "favoriteProducts")as? [Int] ?? [])
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(body)
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
//    func getProducts(token: String) -> AnyPublisher<[Product], Error> {
//        guard let url = URL(string: "https://balink.onlink.dev/products") else {
//            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue(token, forHTTPHeaderField: "Authorization")
//        return URLSession.shared.dataTaskPublisher(for: request)
//            .tryMap { data, response in
//                // throw error when bad server response is received
//                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
//                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
//                    throw NSError(domain: errorResponse.code, code: errorResponse.status, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])
//                }
//                return data
//            }
//            .decode(type: [Product].self, decoder: JSONDecoder())
//            .map { products -> [Product] in
//               // print("products---->", products)
//                return products
//            }
//            .receive(on: RunLoop.main)
//            .eraseToAnyPublisher()
//    }
  

