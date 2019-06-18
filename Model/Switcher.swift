//
//  Switcher.swift
//  XAROUND
//
//  Created by NIK FIKRI on 30/04/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import Foundation
import UIKit

class Switcher {
    
    static func updateRootVC() {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let status = UserDefaults.standard.bool(forKey: "status")
        var rootVC : UIViewController?
        
        print(status)
        
        if (status == true) {
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
        } else {
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeNavController") as! WelcomeNavController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
        UIView.transition(with: window, duration: 0.3, options: .showHideTransitionViews, animations: {
            window.rootViewController = rootVC
        }, completion: { completed in
            // maybe do something here
        })
        
    }
    
}
