//
//  RegisterVC.swift
//  XAROUND
//
//  Created by NIK FIKRI on 02/03/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Firebase

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension RegisterVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField : UITextField) {
        
        //Check if the email's format is correct
        checkEmailFormat(enteredEmail: emailAddressTextField.text!)
        
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
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var securePasswordEntry: UIButton!
    
    var isCorrectEmail: Bool = false
    var isCorrectPassword: Bool = false
    var isSecurePasswordEntry = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAccountButton(isEnabled: false)
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        signUpButton.layer.cornerRadius = 20
    }
    
    func validateEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    func checkEmailFormat(enteredEmail: String) {
        print("\nSTATUS:")
        
        //Firstly, check if email textfield is empty
        if (emailAddressTextField.text!.isEmpty) {
            isCorrectEmail = false
            createAccountButton(isEnabled: false)
        } else {
            //If not empty, check if the email's format is correct
            if (validateEmail(enteredEmail: emailAddressTextField.text!)) {
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
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = #colorLiteral(red: 0, green: 0.5882352941, blue: 1, alpha: 1)
        } else {
            signUpButton.backgroundColor = #colorLiteral(red: 0, green: 0.5882352941, blue: 1, alpha: 1)
            signUpButton.isEnabled = false
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        
        //TODO: Create the user
        Auth.auth().createUser(withEmail: emailAddressTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("Registration successful!")
                //TODO: Send the user info to Firebase and save it in our database
                let usersDB = Database.database().reference().child("Users")
                
                let userInfo = ["Email": self.emailAddressTextField.text!, "Password": self.passwordTextField.text!]
                
                usersDB.childByAutoId().setValue(userInfo) {
                    (error, reference) in
                    if error != nil {
                        print(error!)
                    } else {
                        print("User info saved successfully!")
                    }
                }
                
                //TODO: Sign in the user
                Auth.auth().signIn(withEmail: self.emailAddressTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                    if error != nil {
                        print(error!)
                    } else {
                        print("Log in successful!")
                        UserDefaults.standard.set(true, forKey: "status")
                        Switcher.updateRootVC()
                    }
                }
            }
        }
    }
    
    
    @IBAction func securePasswordEntryButtonPressed(_ sender: Any) {
        if (isSecurePasswordEntry == true) {
            isSecurePasswordEntry = false
            passwordTextField.isSecureTextEntry = false
            securePasswordEntry.setTitle("Hide password", for: .normal)
        } else {
            isSecurePasswordEntry = true
            passwordTextField.isSecureTextEntry = true
            securePasswordEntry.setTitle("Reveal password", for: .normal)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
