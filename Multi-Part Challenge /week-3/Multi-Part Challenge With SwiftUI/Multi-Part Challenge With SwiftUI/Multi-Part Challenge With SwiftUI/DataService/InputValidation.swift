//
//  InputValidation.swift
//  Multi-Part Challenge With SwiftUI
//
//  Created by Balink on 04/07/2023.
//

import Foundation

class InputValidation {
    
    @Published var isInputValid = true
    @Published var errorMessage = ""
    
    func isValid(firstName: String? = nil, lastName: String? = nil,
                 userName: String,password: String) {
        
        if let firstName = firstName, let lastName = lastName {
            if !self.isValidInput(input: firstName) {
                self.errorMessage = "First Name requires A minimum length of 2 characters"
                self.isInputValid = false
                return
            }
            if !self.isValidInput(input: lastName) {
                self.errorMessage = "Last Name requires A minimum length of 2 characters"
                self.isInputValid = false
                return
            }
        }
        
        if !self.isValidUsername(input: userName) {
            self.errorMessage = "Invalid email format"
            self.isInputValid = false
            return
        }
        if !self.isValidPassword(input: password) {
            self.errorMessage = "Password requires A minimum length of 5 characters, and contain at least one uppercase and one lowercase letter"
            self.isInputValid = false
            return
        }
        self.isInputValid = true
    }
    
    func isValidInput(input: String) -> Bool {
        if input.isValidWith(regex: "^.{2,}$") {
            return true
        }
        return false
    }
    
    func isValidUsername(input: String) -> Bool {
        if input.isValidWith(regex: "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}") {
            return true
        }
        return false
    }
    
    func isValidPassword(input: String) -> Bool {
        if input.isValidWith(regex: "^(?=.*[a-z])(?=.*[A-Z]).{5,}$") {
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
