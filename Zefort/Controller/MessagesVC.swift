//
//  MessagesVC.swift
//  Zefort
//
//  Created by NIK FIKRI on 18/06/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import Foundation
import Firebase

class MessagesVC: UIViewController {
    
    @IBOutlet weak var questionDescriptionTextView: UITextView!
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var messageComposeView: UIView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendMessageButton: UIButton!
    
    var question: Question?
    var questionMessages = [Post]()
    
    func initData(forQuestion question: Question) {
        self.question = question
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageComposeView.bindToKeyboard()
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        messagesTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "messageCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        questionDescriptionTextView.text = question?.questionDescription
        messageTextField.becomeFirstResponder()
        
        DataService.instance.REF_QUESTIONS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessages(forDesiredQuestion: self.question!, handler: { (returnedQuestionMessages) in
                self.questionMessages = returnedQuestionMessages
                self.messagesTableView.reloadData()
            })
        }
    }
    
    @IBAction func sendMessageButtonTapped(_ sender: Any) {
        if messageTextField.text != "" {
            messageTextField.isEnabled = false
            sendMessageButton.isEnabled = false
            DataService.instance.uploadMessage(withMessage: messageTextField.text!, forUid: Auth.auth().currentUser!.uid, withQuestionKey: question!.key) { (success) in
                if (success) {
                    self.messageTextField.text = ""
                    self.messageTextField.isEnabled = true
                    self.sendMessageButton.isEnabled = true
                }
            }
        }
    }
    
}

extension MessagesVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageCell
        let message = questionMessages[indexPath.row]
        
        DataService.instance.getUsername(forUID: message.senderID) { (email) in
            cell.configureCell(profileImage: UIImage(named: "anonymous")!, email: email, content: message.content, isExcellentTutor: true)
        }
        return cell
    }
}
