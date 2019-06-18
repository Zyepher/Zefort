//
//  ProfileVC.swift
//  XAROUND
//
//  Created by NIK FIKRI on 28/02/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Firebase

class CreateQuestionVC: UIViewController {

    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var emailSearchTextField: UnderLineTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedTutor: UILabel!
    
    var emailArray = [String]()
    var chosenUser = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getEmailsForEmptySearchQuery()
        emailSearchTextField.delegate = self
        emailSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        descriptionTextView.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sendButton.isEnabled = false
    }
    
    func getEmailsForEmptySearchQuery() {
        DataService.instance.getEmails(forEmptySearchQuery: emailSearchTextField.text!) { (returnedEmailArray) in
            self.emailArray = returnedEmailArray
            self.tableView.reloadData()
        }
    }
    
    @objc func textFieldDidChange() {
        if (emailSearchTextField.text == "") {
            getEmailsForEmptySearchQuery()
        } else {
            DataService.instance.getEmails(forFilledSearchQuery: emailSearchTextField.text!) { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func sendTapped(_ sender: Any) {
        if (descriptionTextView.text != "") {
            DataService.instance.getIds(forUsernames: chosenUser) { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                DataService.instance.createQuestion(withDescription: self.descriptionTextView.text!, forUserIds: userIds, handler: { (questionCreated) in
                    if questionCreated {
                        self.navigationController?.popToRootViewController(animated: true)
                    } else {
                        print("Question could not be created, please try again..")
                    }
                })
            }
        }
    }
}

extension CreateQuestionVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell() }
        
        let profileImage = UIImage(named: "anonymous")
        
        if (chosenUser == emailArray[indexPath.row]) {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        chosenUser = emailArray[indexPath.row]
        chosenUser = cell.emailLabel.text!
        selectedTutor.text = ("Selected tutor: \(chosenUser)")
        sendButton.isEnabled = true
        tableView.reloadData()
    }
}

extension CreateQuestionVC: UITextFieldDelegate {
    
}
