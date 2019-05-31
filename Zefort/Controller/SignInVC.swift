//
//  SignInViewController.swift
//  XAROUND
//
//  Created by NIK FIKRI on 23/02/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signinButton: UIButton!
    
    var emailAddressIsFilled: Bool = false
    var passwordIsFilled: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        signinButton.isEnabled = false
        signinButton.layer.cornerRadius = 20
    }
    
    @IBAction func signinButtonPressed(_ sender: Any) {
        //TODO: Log in the user

        
        Auth.auth().signIn(withEmail: emailAddressTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {

                if (error?.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted.") {
                    self.showAlert(title: "Please try again...", message: "The email you entered does not exist in our records. Please double-check and try again.", handlerOK: { (action) in
                        
                    }, handlerCancel: { (actionCancel) in
                        
                    })
                } else if (error?.localizedDescription == "The password is invalid or the user does not have a password.") {
                    self.showAlert(title: "Please try again...", message: "The password you entered does not match with our record. Please double-check and try again.", handlerOK: { (action) in
                        
                    }, handlerCancel: { (actionCancel) in
                        
                    })
                }

            } else {
                UserDefaults.standard.set(true, forKey: "status")
                Switcher.updateRootVC()
            }
        }
    }
    
    func validateEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func emailTextFieldDidChanged(_ sender: Any) {
        
        if (emailAddressTextField.text!.isEmpty) {
            signinButton.isEnabled = false
        }
        
        if (validateEmail(enteredEmail: emailAddressTextField.text!)) {
            signinButton.isEnabled = true
        } else {
            signinButton.isEnabled = false
        }
    }
    
    @IBAction func passwordTextFieldDidChanged(_ sender: Any) {
        if (passwordTextField.text!.count > 0){
            signinButton.isEnabled = true
        }
    }
    
}
