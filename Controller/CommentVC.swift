//
//  PostCommentVC.swift
//  XAROUND
//
//  Created by NIK FIKRI on 16/05/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Firebase

class CommentVC: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var composeView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var userProfilePic: UIImageView!
    
    func initData() {
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllCommentsFor(desiredPost: AppDelegate.chosenPost, handler: { (returnedCommentArray) in
                AppDelegate.commentArray = returnedCommentArray
                self.commentTableView.reloadData()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundView.bindToKeyboard()
        userProfilePic.bindToKeyboard()
        commentTextField.bindToKeyboard()
        sendButton.bindToKeyboard()
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTextField.delegate = self
        commentTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postCell")

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tableViewTapped))
        
        commentTableView.addGestureRecognizer(tapGesture)
        commentTableView.layoutMargins = UIEdgeInsets.zero
        commentTableView.separatorInset = UIEdgeInsets.zero
        commentTableView.separatorStyle = .none
        
        configureTableView()
    }
    
    @objc func tableViewTapped() {
        commentTextField.endEditing(true)
    }

    func configureTableView() {
        commentTableView.rowHeight = UITableView.automaticDimension
        commentTableView.estimatedRowHeight = 120.0
    }
    
    @IBAction func sendTapped(_ sender: AnyObject) {
        commentTextField.endEditing(true)
        commentTextField.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = Database.database().reference().child("Comments")
        
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email,
                                 "MessageBody": commentTextField.text!]
        
        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            
            if error != nil {
                print(error!)
            }
            else {
                print("Message saved successfully!")
            }
            
            self.commentTextField.isEnabled = true
            self.sendButton.isEnabled = true
            self.commentTextField.text = ""
        }
    }

}

extension CommentVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate.commentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        
        cell.postBody.text = AppDelegate.commentArray[indexPath.row].content
        cell.postSender.text = AppDelegate.commentArray[indexPath.row].senderID
        cell.viewCommentLabel.isHidden = true
        cell.rightChevron.isHidden = true
        cell.likeButton.isHidden = true
        cell.likeLabel.isHidden = true
        cell.commentIcon.isHidden = true
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
}

