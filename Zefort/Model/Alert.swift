//
//  Alert.swift
//  XAROUND
//
//  Created by NIK FIKRI on 23/05/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension UIViewController {
    
    func credentialShowAlert(title: String, message: String, handlerOK:((UIAlertAction) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: handlerOK)
        
        alert.addAction(action)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
