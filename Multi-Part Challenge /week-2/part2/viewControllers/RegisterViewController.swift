//
//  ViewController.swift
//  part2
//
//  Created by Balink on 22/06/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    var token: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
    }
    
    @IBAction func registerPreesed(_ sender: UIButton) {
        
        guard let firstname = self.firstNameInput.text, firstname.count > 3 else {
            showAlert(message: "first name")
            return
        }
        guard let lastname = self.lastNameInput.text, lastname.count > 3 else {
            showAlert(message: "last name")
            return
        }
        guard let username = self.userNameInput.text, self.isValidUsername(input: username) else {
            showAlert(message: "Invalid email format")
            return
        }
        guard let password = self.passwordInput.text, self.isValidPassword(input: password) else {
            showAlert(message: "Password must contains at least one lowercase ,uppercase ,digit, and special character (@, #, $, %, ^, &, +, =)")
            return
        }
        sender.configuration?.showsActivityIndicator = true
        Task{
            // if input is valid, sends register info to server to retrieve a token
            do {
                try token = await DataService.shared.register(firstname: firstname,
                                                              lastname: lastname,
                                                              username:username,
                                                              password: password)
                UserDefaults.standard.set(token, forKey: "token")
                let categoriesView = CategoriesViewController()
                self.navigationController?.pushViewController(categoriesView, animated: true)
            } catch let error as ServerError {
                showAlert(message: error.message)
            }
        }
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
    
    func showAlert (message:String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
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

