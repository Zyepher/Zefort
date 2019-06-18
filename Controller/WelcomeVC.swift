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
    
    @IBOutlet weak var UINavigationItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSignInVC", sender: self)
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToRegisterVC", sender: self)
        
    }
    
    @IBAction func unwindToWelcomeVC(for unwindSegue: UIStoryboardSegue) { }
    
}
