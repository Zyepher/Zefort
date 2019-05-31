//
//  PostTableViewCell.swift
//  XAROUND
//
//  Created by NIK FIKRI on 13/03/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Foundation

class PostCell: UITableViewCell {

    @IBOutlet weak var postSender: UILabel!
    @IBOutlet weak var postBody: UILabel!
    @IBOutlet weak var viewCommentLabel: UILabel!
    @IBOutlet weak var rightChevron: UIImageView!
    @IBOutlet weak var userDisplayPicture: UIImageView!
    @IBOutlet weak var numberOfLikes: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    var x : Int = 2
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func likeButtonTapped(_ sender: Any) {
        
        likeButton.isSelected = !likeButton.isSelected
        
        if (likeButton.isSelected) {
            x = x + 1
            numberOfLikes.text = "\(x) likes"
        } else {
            x = x - 1
            numberOfLikes.text = "\(x) likes"
        }
        
    }
    
    @IBAction func moreButtonTapped(_ sender: Any) {
    }
    
}
