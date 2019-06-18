//
//  PostTableViewCell.swift
//  XAROUND
//
//  Created by NIK FIKRI on 13/03/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Foundation

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var excellentTutorImage: UIImageView!
    
    func configureCell(profileImage: UIImage, email: String, content: String, isExcellentTutor: Bool) {
        self.profileImage.image = profileImage
        self.emailLabel.text = email
        self.contentLabel.text = content
        if (isExcellentTutor) {
            self.excellentTutorImage.image = UIImage(named: "superhost")
        }
    }
    
}
