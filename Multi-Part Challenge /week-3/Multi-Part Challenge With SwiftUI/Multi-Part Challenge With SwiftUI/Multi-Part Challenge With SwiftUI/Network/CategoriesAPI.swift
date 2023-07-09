//
//  CategoriesAPI.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 07/07/2023.
//

import Foundation
import Combine

class CategoriesAPI {
    static var shared = CategoriesAPI()
    
    func getCategories() -> AnyPublisher< [String], Error>  {
        let token = UserDefaults.standard.string(forKey: "accessToken")
        guard let url = URL(string: "https://balink.onlink.dev/categories") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return APIUtils.sendRequest(url: url, method: "GET", token: token)
            .tryMap { data, response in
                return try APIUtils.handleResponse(data: data, response: response)
            }
            .decode(type: [String].self, decoder: JSONDecoder())
            .map { categories -> [String] in
                return categories
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
