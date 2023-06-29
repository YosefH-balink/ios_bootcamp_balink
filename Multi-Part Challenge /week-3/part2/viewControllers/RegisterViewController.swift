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
    
  //  var token: String?
    var registerViewModle = RegisterViewModle()
    
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
        guard let username = self.userNameInput.text, self.registerViewModle.isValidUsername(input: username) else {
            showAlert(message: "Invalid email format")
            return
        }
        guard let password = self.passwordInput.text, self.registerViewModle.isValidPassword(input: password) else {
            showAlert(message: "Password must contains at least one lowercase ,uppercase ,digit, and special character (@, #, $, %, ^, &, +, =)")
            return
        }
            sender.configuration?.showsActivityIndicator = true
            registerViewModle.register(firstname: firstname, lastname: lastname, username: username, password: password)
            let categoriesView = CategoriesViewController()
            self.navigationController?.pushViewController(categoriesView, animated: true)
    }
        
    func showAlert (message:String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}




