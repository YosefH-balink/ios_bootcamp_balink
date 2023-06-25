//
//  ViewController.swift
//  Multi-Part Challenge Week-1
//
//  Created by Balink on 15/06/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false
        self.title = "Login"
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    var userName:String=""
    var password:String = ""
    var isValidName:Bool = false
    var isValidPassword:Bool = false
    
    @IBAction func nameInput(_ sender: UITextField) {
        userName = sender.text ??  ""
        isValidName = userName.isValidWith(regex: "^[A-Za-z]+$")
        if isValidName && userName.count > 4 && isValidPassword{
            loginButton.isEnabled = true
        }else{
            loginButton.isEnabled = false
        }
    }
    
    @IBAction func passwordInput(_ sender: UITextField) {
            password = sender.text ?? ""
            isValidPassword = password.isValidWith(regex: "^[A-Za-z0-9]+$")
            if isValidPassword && password.count > 6 && isValidName{
                loginButton.isEnabled = true
            }else{
                loginButton.isEnabled = false
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let Welcome_Page = segue.destination as? Welcome_PageViewController
        else { return }
        Welcome_Page.name = self.userName
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






