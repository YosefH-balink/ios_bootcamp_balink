//
//  DataService.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 29/06/2023.
//

import Foundation
import Combine

struct registerBody: Codable {
    let firstname: String
    let lastname: String
    let username: String
    let password: String
}

struct AccessToken: Decodable {
    let token: String?
    let type: String?
    let expire: Int?
}

struct ErrorResponse: Codable {
    let code: String
    let message: String
    let status: Int
}

private let tokenURL: URL? = {
       var components = URLComponents()
       components.scheme = "https"
       components.host = "balink.onlink.dev"
       components.path = "/users/register"
       return components.url
   }()

struct Product: Codable, Identifiable, Hashable {
    let id: Int?
    let title: String?
    let description: String?
    let price: Double?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
}

class DataService {

    func getAccessToken(firstname: String, lastname: String, username: String, password: String) -> AnyPublisher<String, Error> {
        
        guard let url = tokenURL else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let body = registerBody(firstname: firstname, lastname: lastname, username: username, password: password)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                // throw error when bad server response is received
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
    
    
    func getProducts(token: String) -> AnyPublisher<[Product], Error> {
        guard let url = URL(string: "https://balink.onlink.dev/products") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                // throw error when bad server response is received
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    throw NSError(domain: errorResponse.code, code: errorResponse.status, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])
                }
                return data
            }
            .decode(type: [Product].self, decoder: JSONDecoder())
            .map { products -> [Product] in
               // print("products---->", products)
                return products
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    
    
}
