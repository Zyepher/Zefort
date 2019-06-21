//
//  ReviewCell.swift
//  Zefort
//
//  Created by NIK FIKRI on 20/06/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var reviewDateLabel: UILabel!
    @IBOutlet weak var memberSinceLabel: UILabel!
    
    func configureCell(image: UIImage, name: String, content: String, reviewMonth: String, memberSince: String) {
        self.profileImage.image = image
        self.nameLabel.text = name
        self.contentLabel.text = content
        self.reviewDateLabel.text = ("Reviewed in \(reviewMonth)")
        self.memberSinceLabel.text = ("Member since \(memberSince)")
    }
    
}

