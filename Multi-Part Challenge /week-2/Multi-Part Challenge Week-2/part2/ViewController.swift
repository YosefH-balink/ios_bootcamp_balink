//
//  ViewController.swift
//  part2
//
//  Created by Balink on 22/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    var token:String?
    var products:[Product]?
    var categoriesView:CategoriesViewController?
    
    var firstname:String?
    var lastname:String?
    var username:String?
    var password:String?
    var isValidName:Bool = false
    var isValidPassword:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
    }
    func showAlert (message:String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func registerPreesed(_ sender: UIButton) {
        firstname = firstNameInput.text ?? ""
        lastname = lastNameInput.text ?? ""
        username = userNameInput.text ?? ""
        password = passwordInput.text ?? ""
        
        let isUsernameInputValid = isInputValid(input: username! , type: "username")
        if !isUsernameInputValid.isValid {
            showAlert(message: isUsernameInputValid.errorMessage)
            return
        }
        
        let isPasswordInputValid = isInputValid(input: password! , type: "password")
        if !isPasswordInputValid.isValid {
            showAlert(message: isPasswordInputValid.errorMessage)
            return
        }
        
        sender.configuration?.showsActivityIndicator = true
        Task{
            do {
                try token = await DataService.shared.register(firstname: firstname ?? "", lastname: lastname ?? "", username: username ?? "", password: password ?? "")
            } catch let error as ServerError {
                showAlert(message: error.message)
            }
            
            do {
                try products = await DataService.shared.getProducts(token: token ?? "")
                categoriesView = CategoriesViewController()
                categoriesView!.products =  products!
                self.navigationController?.pushViewController(categoriesView!, animated: true)
            } catch let error as ServerError {
                showAlert(message: error.message)
            }
        }
    }
    
    func isInputValid(input: String, type: String) -> (isValid: Bool, errorMessage: String) {
        switch type {
        case "username":
            let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            if input.isValidWith(regex: emailRegex) {
                return (true, "")
            } else {
                return (false, "Invalid email format")
            }
        case "password":
            if input.count >= 4 && input.rangeOfCharacter(from: .uppercaseLetters) != nil {
                return (true, "")
            } else {
                return (false, "Password must be at least 4 characters long and include an uppercase letter")
            }
        default:
            return (false, "Invalid input type")
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

