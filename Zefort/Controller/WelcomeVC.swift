//
//  WelcomeVC.swift
//  XAROUND
//
//  Created by NIK FIKRI on 24/04/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Firebase

class WelcomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.5882352941, blue: 1, alpha: 1)]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToSignInVC", sender: self)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToRegisterVC", sender: self)
    }
    
    @IBAction func unwindToWelcomeVC(for unwindSegue: UIStoryboardSegue) { }
    
}
