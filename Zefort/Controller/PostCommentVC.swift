//
//  PostCommentVC.swift
//  XAROUND
//
//  Created by NIK FIKRI on 16/05/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Firebase

class PostCommentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Declare instance variables here
    //var commentArray : [Comment] = [Comment]()
    var postArray : [Post] = [Post]()
    var pew: Post?
    
    @IBOutlet weak var postTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set yourself as the delegate and datasource here:
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.layoutMargins = UIEdgeInsets.zero
        postTableView.separatorInset = UIEdgeInsets.zero
        postTableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        //TODO: Set yourself as the delegate of the text field here:
        
        //TODO: Set the tapGesture here:
        
        //TODO: Register your MessageCell.xib file here:
        postTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postCell")
        
        configureTableView()
        retrievePost()
    }
    
    ////////////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    
    //TODO: Declare CellForRowAtIndexPath here:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        
        cell.postBody.text = postArray[indexPath.row].postBody
        cell.postSender.text = postArray[indexPath.row].postSender
        cell.viewCommentLabel.isHidden = true
        cell.rightChevron.isHidden = true
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
        
    }
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postArray.count
        
    }
    
    //TODO: Declare configureTableView here:
    func configureTableView() {
        
        postTableView.rowHeight = UITableView.automaticDimension
        postTableView.estimatedRowHeight = 640.0
        
    }
    
    ////////////////////////////////////////////////
    
    //TODO: Create the retrievePosts method here:
    func retrievePost() {
        self.postArray.insert(pew!, at: 0)
        self.configureTableView()
        self.postTableView.reloadData()
    }
    
}
