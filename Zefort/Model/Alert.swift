//
//  Alert.swift
//  XAROUND
//
//  Created by NIK FIKRI on 23/05/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, handlerOK:((UIAlertAction) -> Void)?, handlerCancel: ((UIAlertAction) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: handlerOK)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: handlerCancel)
        
        alert.addAction(action)
        alert.addAction(actionCancel)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
