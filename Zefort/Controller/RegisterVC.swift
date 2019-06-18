//
//  RegisterVC.swift
//  XAROUND
//
//  Created by NIK FIKRI on 02/03/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Firebase

extension RegisterVC: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField : UITextField) {

        //Check if the email's format is correct
        checkEmailFormat(enteredEmail: emailTextField.text!)

        //Check if the password's format is correct
        checkPasswordFormat(enteredPassword: passwordTextField.text!)

        //Check if both email and password is correct
        if (isCorrectEmail && isCorrectPassword) {
            createAccountButton(isEnabled: true)
        } else {
            createAccountButton(isEnabled: false)
        }
    }
}

class RegisterVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var securePasswordEntryButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var isCorrectEmail: Bool = false
    var isCorrectPassword: Bool = false
    var isSecurePasswordEntry = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.bindToKeyboard()
        hideKeyboardWhenTappedAround()
        
        createAccountButton(isEnabled: false)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        nextButton.layer.cornerRadius = 20
        
    }
    
    func validateEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    func checkEmailFormat(enteredEmail: String) {
        print("\nSTATUS:")
        
        //Firstly, check if email textfield is empty
        if (emailTextField.text!.isEmpty) {
            isCorrectEmail = false
            createAccountButton(isEnabled: false)
        } else {
            //If not empty, check if the email's format is correct
            if (validateEmail(enteredEmail: emailTextField.text!)) {
                isCorrectEmail = true
            } else {
                isCorrectEmail = false
            }
        }
    }
    
    func checkPasswordFormat(enteredPassword: String) {
        //Firstly, check if password textfield is empty
        if (enteredPassword.isEmpty) {
            isCorrectPassword = false
            createAccountButton(isEnabled: false)
        } else {
            //If not empty, check if its at least 8 characters
            if (enteredPassword.count >= 8) {
                isCorrectPassword = true
            }
        }
    }
    
    func createAccountButton(isEnabled: Bool) {
        if (isEnabled) {
            nextButton.isEnabled = true
            nextButton.alpha = 1.0
        } else {
            nextButton.isEnabled = false
            nextButton.alpha = 0.6
        }
    }
    
    
    @IBAction func nextTapped(_ sender: Any) {
        AuthService.instance.registerUser(withEmail: self.emailTextField.text!, andPassword: self.passwordTextField.text!) { (success, error) in
            if (success) {
                AuthService.instance.signinUser(withEmail: self.emailTextField.text!, andPassword: self.passwordTextField.text!, signinComplete: { (success, nil) in
                    UserDefaults.standard.set(true, forKey: "status")
                    Switcher.updateRootVC()
                })
            } else {
                self.credentialShowAlert(title: "", message: "The email address is already in use by another account.", handlerOK: { (action) in })
            }
        }
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
    
}
