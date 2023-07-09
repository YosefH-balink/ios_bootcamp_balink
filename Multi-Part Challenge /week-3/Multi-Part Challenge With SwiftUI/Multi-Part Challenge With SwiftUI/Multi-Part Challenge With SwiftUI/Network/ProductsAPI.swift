//
//  ProductsAPI.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 07/07/2023.
//

import Foundation
import Combine

class ProductsAPI {
    static var shared = ProductsAPI()
  
    func fetchProducts(categorie: String? = nil, products: ProductsRequestType) -> AnyPublisher<[Product], Error> {
        let token = UserDefaults.standard.string(forKey: "accessToken")
        guard let url = URL(string: "https://balink.onlink.dev/\(products.rawValue)\(categorie ?? "")") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        var request: URLRequest
        if products == .favorites {
            let favoriteProducts = UserDefaults.standard.array(forKey: "favoriteProducts") as? [Int] ?? []
            let requestData = try? JSONSerialization.data(withJSONObject: ["products": favoriteProducts])
            request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = requestData
        } else {
            request = URLRequest(url: url)
            request.httpMethod = "GET"
        }
        return APIUtils.sendRequest(url: url, method: request.httpMethod ?? "", token: token, body: request.httpBody)
            .tryMap { data, response in
                return try APIUtils.handleResponse(data: data, response: response)
            }
            .decode(type: [Product].self, decoder: JSONDecoder())
            .map { products -> [Product] in
                return products
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
