//
//  RegisterVC.swift
//  Zefort
//
//  Created by NIK FIKRI on 02/05/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var securePasswordEntryButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var AcceptandSignUpButton: UIButton!
    
    var isSecurePasswordEntry = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction func securePasswordEntryTapped(_ sender: Any) {
        if (isSecurePasswordEntry == true) {
            isSecurePasswordEntry = false
            passwordTextField.isSecureTextEntry = false
            securePasswordEntryButton.setTitle("Hide password", for: .normal)
        } else {
            isSecurePasswordEntry = true
            passwordTextField.isSecureTextEntry = true
            securePasswordEntryButton.setTitle("Reveal password", for: .normal)
        }
    }
    
    func validateEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        if (emailTextField.text!.isEmpty) {
            self.credentialShowAlert(title: "Please try again...", message: "The email text field is empty. Please double-check and try again.", handlerOK: { (action) in })
        } else if !(validateEmail(enteredEmail: emailTextField.text!)) {
            self.credentialShowAlert(title: "Please try again...", message: "The email format you entered is invalid. Please double-check and try again.", handlerOK: { (action) in })
        } else if (passwordTextField.text!.isEmpty) {
            self.credentialShowAlert(title: "Please try again...", message: "The password text field is empty. Please double-check and try again.", handlerOK: { (action) in })
        } else if (passwordTextField.text!.count <= 5) {
            self.credentialShowAlert(title: "Please try again...", message: "Your password must be at least 6 characters. Please double-check and try again.", handlerOK: { (action) in })
        } else {
            AuthService.instance.registerUser(withEmail: self.emailTextField.text!, andPassword: self.passwordTextField.text!) { (success, error) in
                if (success) {
                    AuthService.instance.signinUser(withEmail: self.emailTextField.text!, andPassword: self.passwordTextField.text!, signinComplete: { (success, nil) in
                        if (success) {
                            UserDefaults.standard.set(true, forKey: "status")
                            Switcher.updateRootVC()
                        }
                    })
                } else {
                    self.credentialShowAlert(title: "", message: "The email address is already in use by another account.", handlerOK: { (action) in })
                }
            }
        }
    }
    
}

