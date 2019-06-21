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
    
    @IBOutlet weak var messagesTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var endChatButton: UIButton!
    @IBOutlet weak var chatView: UIView!
    
    var question: Question?
    var questionMessages = [Post]()
    let refreshControl = UIRefreshControl()
    
    func initData(forQuestion question: Question) {
        self.question = question
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        messagesTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "messageCell")
        getAllMessages()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        messagesTableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: Any) {
        messagesTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllMessages()
        messageTextField.becomeFirstResponder()
        if (question!.status) {
            endQuestion(adjustTableViewHeight: true)
        }
    }
    
    func endQuestion(adjustTableViewHeight: Bool) {
        self.messageTextField.isEnabled = false
        self.sendMessageButton.isEnabled = false
        self.status.text! = "Completed"
        self.status.textColor = #colorLiteral(red: 0, green: 0.5882352941, blue: 1, alpha: 1)
        self.endChatButton.isHidden = true
        if (adjustTableViewHeight) {
            messagesTableViewHeight.constant += 257
        }
    }
    
    func getAllMessages() {
        DataService.instance.REF_QUESTIONS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessages(forDesiredQuestion: self.question!, handler: { (returnedQuestionMessages) in
                self.questionMessages = returnedQuestionMessages
                self.messagesTableView.reloadData()
                if (self.questionMessages.count > 0) {
                    self.messagesTableView.scrollToRow(at: IndexPath(row: self.questionMessages.count - 1, section: 0), at: .bottom, animated: true)
                }
            })
        }
    }
    
    @IBAction func endChatTapped(_ sender: Any) {
        messagesTableViewHeight.constant += 257
        let endChatPopOut = UIAlertController(title: "", message: "Are you sure you want to end chat?", preferredStyle: .alert)
        let endChatAction = UIAlertAction(title: "End Chat", style: .destructive) { (endChatTapped) in
            DataService.instance.updateMessageStatus(withQuestionKey: self.question!.key, forStatus: true, updateComplete: { (updateCompleted) in
                self.endQuestion(adjustTableViewHeight: false)
            })
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (cancelTapped) in
            self.messagesTableViewHeight.constant -= 257
            self.getAllMessages()
        }
        endChatPopOut.addAction(endChatAction)
        endChatPopOut.addAction(cancelAction)
        present(endChatPopOut, animated: true, completion: nil)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
                    self.messageTextField.becomeFirstResponder()
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
            cell.configureCell(profileImage: UIImage(named: "anonymous")!, email: email, content: message.content, isExcellentTutor: false)
        }
        return cell
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
