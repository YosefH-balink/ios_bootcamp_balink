//
//  ViewController.swift
//  Multi-Part Challenge Week-1
//
//  Created by Balink on 15/06/2023.
//

import UIKit
import Combine

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        loginSubscriber = validToSubmit
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: loginButton)
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    var userName:String=""
    var password:String = ""
    //Define publishers
    @Published var isValidName:Bool = false
    @Published var isValidPassword:Bool = false
    
    //Define subscriber
    private var loginSubscriber: AnyCancellable?
    
    // combine publishers into single stream
    private var  validToSubmit: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest($isValidName, $isValidPassword)
            .map {validUserName, validPassword in
                return validUserName && validPassword
            }.eraseToAnyPublisher()
    }
    
    @IBAction func nameInput(_ sender: UITextField) {
        userName = sender.text ??  ""
        isValidName = userName.isValidWith(regex: "^[A-Za-z]+$")
    }
    
    @IBAction func passwordInput(_ sender: UITextField) {
        password = sender.text ?? ""
        isValidPassword = password.isValidWith(regex: "^[A-Za-z0-9]+$")
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






