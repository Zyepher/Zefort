//
//  Groups.swift
//  XAROUND
//
//  Created by NIK FIKRI on 11/06/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class GroupsVC: UIViewController {

    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension GroupsVC
