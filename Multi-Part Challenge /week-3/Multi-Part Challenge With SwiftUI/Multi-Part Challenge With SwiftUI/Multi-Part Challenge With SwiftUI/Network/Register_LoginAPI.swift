//
//  DataService.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 29/06/2023.
//

import Foundation
import Combine

class Register_LoginAPI {
    static var shared = Register_LoginAPI()
   
    func getToken(firstname: String? = nil, lastname: String? = nil, username: String, password: String, requestType: TokenRequestType) -> AnyPublisher< String, Error> {
        guard let url = URL(string: "https://balink.onlink.dev/users/\(requestType.rawValue)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        let body = RegisterBody(firstname: firstname, lastname: lastname, username: username, password: password)
        let requestData = try? JSONEncoder().encode(body)
        return APIUtils.sendRequest(url: url, method: "POST", token: nil, body: requestData)
            .tryMap { data, response in
                return try APIUtils.handleResponse(data: data, response: response)
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
}




