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
        if (indexPath.section == 3 && indexPath.row == 0) {
            let signOutPopOut = UIAlertController(title: "", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
            let signOutAction = UIAlertAction(title: "Log Out", style: .destructive) { (buttonTapped) in
                do {
                    try Auth.auth().signOut()
                    UserDefaults.standard.set(false, forKey: "status")
                    Switcher.updateRootVC()
                } catch {
                    print(error)
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (buttonTapped) in
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
            
            signOutPopOut.addAction(signOutAction)
            signOutPopOut.addAction(cancelAction)
            present(signOutPopOut, animated: true, completion: nil)
        }
    }
    
}


