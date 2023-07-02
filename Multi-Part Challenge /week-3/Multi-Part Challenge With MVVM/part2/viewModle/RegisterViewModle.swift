//
//  RegisterViewModle.swift
//  part2
//
//  Created by Balink on 29/06/2023.
//

import Foundation

class RegisterViewModle {
    private var token: String?
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
    
    func register(firstname:String, lastname:String, username:String, password:String) {
        Task{
            do {
                try token = await DataService.shared.register(firstname: firstname,
                                                              lastname: lastname,
                                                              username:username,
                                                              password: password)
                UserDefaults.standard.set(token, forKey: "token")
            } catch {
                
            }
        }
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
