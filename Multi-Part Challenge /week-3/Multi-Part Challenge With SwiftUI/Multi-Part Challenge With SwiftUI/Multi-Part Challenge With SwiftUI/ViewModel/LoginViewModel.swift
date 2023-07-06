//
//  LoginViewModle.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 02/07/2023.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var userName = ""
    @Published var password = ""
    @Published var serverCompletion = false
    @Published var failure = false
    @Published var errorMessage = ""
    let dataService = DataService.shared
    let inputValidation = InputValidation()
    private var cancellables = Set<AnyCancellable>()
    
    func isValid() {
        inputValidation.isValid(userName: userName,password: password)
        if !inputValidation.isInputValid {
            self.errorMessage = inputValidation.errorMessage
            self.failure = true
        } else {
            fetchAccessToken()
        }
    }
    
    func fetchAccessToken(){
        dataService.getToken(username: userName, password: password, requestType: .login)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.serverCompletion = true
                    break
                case .failure(let error):
                    self.failure = true
                    if let urlError = error as? NSError {
                        self.errorMessage = urlError.localizedDescription
                        print("Error status: \(urlError.code)")
                        print("Error code: \(urlError.domain)")
                        print("Error message: \(urlError.localizedDescription)")
                    }
                }
            }, receiveValue: { accessToken in
                UserDefaults.standard.set(accessToken, forKey: "accessToken")
            })
            .store(in: &cancellables)
    }

}

