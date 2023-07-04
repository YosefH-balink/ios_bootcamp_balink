//
//  RegisterViewModle.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 29/06/2023.
//

import Foundation
import SwiftUI
import Combine

class RegisterViewModel: ObservableObject {
    let dataService = DataService.shared
    let inputValidation = InputValidation()
    private var cancellables = Set<AnyCancellable>()
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var userName = ""
    @Published var password = ""
    @Published var serverCompletion = false
    @Published var failure = false
    @Published var errorMessage = ""
   //@Published var errorCode = ""
    //@Published var errorStatus = 0
   
    
    func isValid() {
        inputValidation.isValid(firstName: firstName,lastName: lastName,
                                userName: userName,password: password)
        if !inputValidation.isInputValid {
            self.errorMessage = inputValidation.errorMessage
            self.failure = true
        } else {
            fetchAccessToken()
        }       
    }

    func fetchAccessToken(){
        dataService.registerGetToken(firstname: firstName, lastname: lastName, username: userName, password: password)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.serverCompletion = true
                    print(completion)  // prints finished
                    break
                case .failure(let error):
                    if let urlError = error as? NSError {
                        self.failure = true
                       // self.errorCode = urlError.domain
                        self.errorMessage = urlError.localizedDescription
                       // self.errorStatus = urlError.code
                        print("Error code: \(urlError.domain)")
                        print("Error message: \(urlError.localizedDescription)")
                        print("Error status: \(urlError.code)")
                    }
                }
            }, receiveValue: { accessToken in
                // print("accessToken--->",accessToken)
                UserDefaults.standard.set(accessToken, forKey: "accessToken")
            })
            .store(in: &cancellables)
    }
}





