//
//  CommunityFeedVC.swift
//  XAROUND
//
//  Created by NIK FIKRI on 12/03/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Declare instance variables here
    var postArray : [Post] = [Post]()
    var feedName : String = "SunwayUniversityPostsFeed"
    var wap : Bool = true
    
    @IBOutlet weak var createPostPressed: UIButton!
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: Set yourself as the delegate and datasource here:
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.layoutMargins = UIEdgeInsets.zero
        feedTableView.separatorInset = UIEdgeInsets.zero
        //feedTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        //TODO: Register your PostCell.xib file here:
        feedTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postCell")
        
        configureTableView()
        retrievePosts()
    }
    
    ////////////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    
    //TODO: Declare CellForRowAtIndexPath here:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        
        cell.postBody.text = postArray[indexPath.row].postBody
        cell.postSender.text = postArray[indexPath.row].postSender
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "goToViewComment", sender: self)
    }

    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    //TODO: Declare configureTableView here:
    func configureTableView() {
        feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.estimatedRowHeight = 640.0
    }
    ////////////////////////////////////////////////
    
    //TODO: Create the retrievePosts method here:
    func retrievePosts() {
        let postDB = Database.database().reference().child(feedName)
        
        postDB.observe(DataEventType.childAdded, with: { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            let text = snapshotValue["PostBody"]!
            let sender = snapshotValue["Sender"]!
            
            let post = Post()
            post.postBody = text
            post.postSender = sender
            
            self.postArray.insert(post, at: 0)
            
            self.configureTableView()
            self.feedTableView.reloadData()
        })
    }
    
    //For switching feed testing, delete if necessary
    func clearPosts() {
        self.postArray.removeAll()
    }
    
    @IBAction func createPostPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToCreatePostVC", sender: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PostCommentVC {
            destination.pew = postArray[(feedTableView.indexPathForSelectedRow?.row)!]
            feedTableView.deselectRow(at: feedTableView.indexPathForSelectedRow!, animated: true)
        }
    }

}
