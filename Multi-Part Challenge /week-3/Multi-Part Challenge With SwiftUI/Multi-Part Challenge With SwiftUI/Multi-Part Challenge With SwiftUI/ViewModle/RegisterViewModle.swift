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
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var userName = ""
    @Published var password = ""
    @Published var serverCompletion = false

    let dataService = DataService()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchAccessToken(){
        dataService.getAccessToken(firstname: firstName, lastname: lastName, username: userName, password: password)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.serverCompletion = true
                    print(completion)  // prints finished
                    break
                case .failure(let error):
                    if let urlError = error as? NSError {
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

    
    func isValidUsername(input: String) -> Bool {
        if input.isValidWith(regex: "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}") {
            return true
        }
        return false
    }
    
    func isValidPassword(input: String) -> Bool {
        if input.isValidWith(regex: "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=]).{8,}$") {
            return true
        }
        return false
    }
}



extension String {
    func isValidWith(regex: String) -> Bool {
        guard let gRegex = try? NSRegularExpression(pattern: regex) else {
            return false
        }
        let range = NSRange(location: 0, length: self.utf16.count)
        if gRegex.firstMatch(in: self, options: [], range: range) != nil {
            return true
        }
        return false
    }
}


