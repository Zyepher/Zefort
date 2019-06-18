//
//  CommunityFeedVC.swift
//  XAROUND
//
//  Created by NIK FIKRI on 12/03/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Firebase

class SessionsVC: UIViewController {

    var questionsArray = [Question]()
    
    @IBOutlet weak var questionsTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionsTableView.delegate = self
        questionsTableView.dataSource = self
        questionsTableView.register(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: "questionCell")
        getAllQuestions()
    
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        questionsTableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: Any) {
        questionsTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func getAllQuestions() {
        DataService.instance.REF_QUESTIONS.observe(.value) { (snapshot) in
            DataService.instance.getAllQuestions { (returnedQuestionsArray) in
                self.questionsArray = returnedQuestionsArray.reversed()
                self.questionsTableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAllQuestions()
    }

}

extension SessionsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = questionsTableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as! QuestionCell
        let question = questionsArray[indexPath.row]
        cell.configureCell(email: question.email, description: question.questionDescription, status: question.status)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToMessageVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MessagesVC {
            destination.question = questionsArray[(questionsTableView.indexPathForSelectedRow?.row)!]
            questionsTableView.deselectRow(at: questionsTableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
}
