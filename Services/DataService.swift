//
//  DataService.swift
//  XAROUND
//
//  Created by NIK FIKRI on 05/06/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_QUESTIONS = DB_BASE.child("questions")
    private var _REF_SESSIONS = DB_BASE.child("sessions")
    private var _REF_CHATS = DB_BASE.child("chats")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_QUESTIONS: DatabaseReference {
        return _REF_QUESTIONS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_SESSIONS
    }
    
    var REF_COMMENTS: DatabaseReference {
        return _REF_CHATS
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>, userStatus: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
        REF_USERS.child(uid).updateChildValues(userStatus)
    }
    
    func getUsername(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapShot) in
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapShot {
                if (user.key == uid) {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func uploadMessage(withMessage message: String, forUid uid: String, withQuestionKey questionKey: String, sendComplete: @escaping (_ status: Bool) -> ()) {
        REF_QUESTIONS.child(questionKey).child("messages").childByAutoId().updateChildValues(["content": message, "senderId": uid])
        sendComplete(true)
    }
    
    func getAllMessages(forDesiredQuestion: Question, handler: @escaping (_ messagesArray: [Post]) -> ()) {
        var questionMessageArray = [Post]()
        REF_QUESTIONS.child(forDesiredQuestion.key).child("messages").observeSingleEvent(of: .value) { (questionMessageSnapshot) in
            guard let questionMessageSnapshot = questionMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for questionMessage in questionMessageSnapshot {
                let content = questionMessage.childSnapshot(forPath: "content").value as! String
                let senderID = questionMessage.childSnapshot(forPath: "senderId").value as! String
                let questionMessage = Post(content: content, senderID: senderID)
                questionMessageArray.append(questionMessage)
            }
            handler(questionMessageArray)
        }
    }
    
    func getEmails(forEmptySearchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()) {
        var usersEmailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let userEmail = user.childSnapshot(forPath: "email").value as! String
                if (query.isEmpty && userEmail != Auth.auth().currentUser?.email) {
                    usersEmailArray.append(userEmail)
                }
            }
            handler(usersEmailArray)
        }
    }
    
    func getEmails(forFilledSearchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()) {
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if (email.contains(query) == true && email != Auth.auth().currentUser?.email) {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func getIds(forUsernames usernames: String, handler: @escaping (_ uidArray: [String]) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            var idArray = [String]()
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if usernames.contains(email) {
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
    }
    
    func createQuestion(withDescription description: String, forUserIds ids: [String], handler: @escaping (_ questionCreated: Bool) -> ()) {
        let email = (Auth.auth().currentUser?.email)!
        REF_QUESTIONS.childByAutoId().updateChildValues(["email": email, "description": description, "members": ids, "status": false])
        handler(true)
    }
    
    func getAllQuestions(handler: @escaping (_ questionsArray: [Question]) -> ()) {
        var questionsArray = [Question]()
        REF_QUESTIONS.observeSingleEvent(of: .value) { (questionSnapshot) in
            guard let questionSnapshot = questionSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for question in questionSnapshot {
                let memberArray = question.childSnapshot(forPath: "members").value as! [String]
                if memberArray.contains((Auth.auth().currentUser?.uid)!) {
                    let email = question.childSnapshot(forPath: "email").value as! String
                    let description = question.childSnapshot(forPath: "description").value as! String
                    let status = question.childSnapshot(forPath: "status").value as! Bool
                    let question = Question(email: email, description: description, members: memberArray, key: question.key, status: status)
                    questionsArray.append(question)
                }
            }
            handler(questionsArray)
        }
    }
        
}

