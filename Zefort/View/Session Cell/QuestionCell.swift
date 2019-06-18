//
//  PostTableViewCell.swift
//  XAROUND
//
//  Created by NIK FIKRI on 13/03/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Foundation

class QuestionCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    func configureCell(email: String, description: String, status: Bool) {
        self.emailLabel.text = email
        self.descriptionLabel.text = description
        if (status) {
            self.statusLabel.text = "Completed"
        } else {
            self.statusLabel.text = "On-going"
        }
    }
}
