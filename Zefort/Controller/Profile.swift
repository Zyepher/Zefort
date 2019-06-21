//
//  Profile.swift
//  Zefort
//
//  Created by NIK FIKRI on 20/06/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Firebase

class Profile: UIViewController {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var about: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        DataService.instance.getAllReviews(forUID: Auth.auth().currentUser!.uid) { (returnedReviews) in
//            if (returnedReviews.count < 2) {
//                self.reviewCount.text = "\(returnedReviews.count) Review"
//            } else {
//                self.reviewCount.text = "\(returnedReviews.count) Reviews"
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DataService.instance.getCurrentUserDetails { (currentUser) in
            self.name.text = currentUser.name
        }
    }
    
}

//extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell() }
//        
//        let profileImage = UIImage(named: "anonymous")
//        
//        cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
//
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
//        chosenUser = emailArray[indexPath.row]
//        chosenUser = cell.emailLabel.text!
//        selectedTutor.text = ("Selected tutor: \(chosenUser)")
//        sendButton.isEnabled = true
//        tableView.reloadData()
//    }
//}

