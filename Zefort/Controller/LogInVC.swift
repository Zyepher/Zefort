//
//  SignInViewController.swift
//  Zefort
//
//  Created by NIK FIKRI on 23/03/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        emailTextField.becomeFirstResponder()
    }
    
    func validateEmail(email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        if (emailTextField.text!.isEmpty) {
            self.showAlert(title: "Please try again...", message: "The email text field is empty. Please double-check and try again.", handlerOK: { (action) in })
        } else if !(self.validateEmail(email: self.emailTextField.text!)) {
            self.showAlert(title: "Please try again...", message: "The email format you entered is invalid. Please double-check and try again.", handlerOK: { (action) in })
        } else if (passwordTextField.text!.isEmpty) {
            self.showAlert(title: "Please try again...", message: "The password text field is empty. Please double-check and try again.", handlerOK: { (action) in })
        } else {
            SVProgressHUD.show()
            AuthService.instance.signinUser(withEmail: emailTextField.text!, andPassword: passwordTextField.text!) { (success, error) in
                if (success) {
                    UserDefaults.standard.set(true, forKey: "status")
                    SVProgressHUD.dismiss()
                    Switcher.updateRootVC()
                } else {
                    SVProgressHUD.dismiss()
                    if (error?.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted.") {
                        self.showAlert(title: "Please try again...", message: "The email you entered does not exist in our record. Please double-check and try again.", handlerOK: { (action) in })
                    } else if (error?.localizedDescription == "The password is invalid or the user does not have a password.") {
                        self.showAlert(title: "Please try again...", message: "The password you entered does not match with our record. Please double-check and try again.", handlerOK: { (action) in })
                    }
                }
            }
        }
    }
    
}
