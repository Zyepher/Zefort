//
//  userSetup.swift
//  Zefort
//
//  Created by NIK FIKRI on 21/06/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//


import UIKit

class UserSetupVC: UIViewController {
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var studentButton: UserTypeButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nameTextField.becomeFirstResponder()
    }

    
    @IBAction func accountTypeTapped(_ sender: Any) {

    }
    
}
