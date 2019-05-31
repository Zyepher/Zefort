//
//  ProfileVC.swift
//  XAROUND
//
//  Created by NIK FIKRI on 28/02/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    @IBOutlet weak var postTextfield: UITextView!
    var feedName : String = "SunwayUniversityPostsFeed"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        postTextfield.becomeFirstResponder()
    }
    
    @IBAction func sendPost(_ sender: Any) {
        
            //TODO: Send the message to Firebase and save it in our database
            let postsDB = Database.database().reference().child(feedName)
        
            let postDictionary = ["Sender": Auth.auth().currentUser?.email, "PostBody": postTextfield.text!]
        
            postsDB.childByAutoId().setValue(postDictionary) {
            (error, reference) in
        
            if error != nil {
                print(error!)
            } else {
                print("Post saved successfully!")
                self.postTextfield.text = ""
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
