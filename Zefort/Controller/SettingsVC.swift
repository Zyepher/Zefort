//
//  SettingsVC.swift
//  XAROUND
//
//  Created by NIK FIKRI on 15/04/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import Foundation
import Firebase

class SettingsVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.section == 4 && indexPath.row == 0) {
            do {
                try Auth.auth().signOut()
                
                UserDefaults.standard.set(false, forKey: "status")
                Switcher.updateRootVC()
            }
            catch {
                print("error: there was a problem signing out")
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


