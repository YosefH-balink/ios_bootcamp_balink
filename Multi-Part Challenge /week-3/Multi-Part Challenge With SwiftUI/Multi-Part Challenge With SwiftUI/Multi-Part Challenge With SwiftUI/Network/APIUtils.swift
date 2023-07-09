//
//  APIUtils.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 09/07/2023.
//

import Foundation

class APIUtils {
    
    static func handleResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw NSError(domain: errorResponse.code, code: errorResponse.status, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])
        }
        return data
    }
    
    static func sendRequest(url: URL, method: String, token: String?, body: Data? = nil) -> URLSession.DataTaskPublisher {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token ?? "", forHTTPHeaderField: "Authorization")
        request.httpBody = body
        return URLSession.shared.dataTaskPublisher(for: request)
    }
}
