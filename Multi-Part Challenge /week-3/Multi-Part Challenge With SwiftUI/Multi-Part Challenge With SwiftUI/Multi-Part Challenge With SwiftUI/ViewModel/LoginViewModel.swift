//
//  LoginViewModle.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 02/07/2023.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    let dataService = DataService.shared
    private var cancellables = Set<AnyCancellable>()
    @Published var userName = ""
    @Published var password = ""
    @Published var serverCompletion = false
    @Published var failure = false
    @Published var errorCode = ""
    @Published var errorMessage = ""
    @Published var errorStatus = 0
   
    func fetchAccessToken(){
        dataService.loginGetToken(username: userName, password: password)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.serverCompletion = true
                    print("serverCompletion--->", self.serverCompletion)
                    print(completion)  // prints finished
                    break
                case .failure(let error):
                    self.failure = true
                    if let urlError = error as? NSError {
                        self.errorCode = urlError.domain
                        self.errorMessage = urlError.localizedDescription
                        self.errorStatus = urlError.code
                        print("Error status: \(urlError.code)")
                        print("Error code: \(urlError.domain)")
                        print("Error message: \(urlError.localizedDescription)")
                        print("Error status: \(urlError.code)")
                    }
                }
            }, receiveValue: { accessToken in
                print("accessToken--->",accessToken)
                UserDefaults.standard.set(accessToken, forKey: "accessToken")
            })
            .store(in: &cancellables)
    }

}

