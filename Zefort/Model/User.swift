//
//  User.swift
//  XAROUND
//
//  Created by NIK FIKRI on 05/02/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import Foundation

class User {
    
    var userID : Int = 0
    var username : String = "" //for your friend to add you. Adding will allow your friend to tag you in a comment section and to message you privately
    var userTagID : String = "" //when your friend tagged you in a comment and publish the comment, we will reveal your tagID instead of your username to protect your privacy
    var userPassword : String = ""
    var userAboutMe : String = ""
    var userEmailAddress : String = ""
    var userPhoneNumber : String = ""
    var userIsVerified : Bool = false
    
    init() {
        
    }
    
    convenience init (userChosenUserName : String) {
        self.init()
        username = userChosenUserName
    }
    
    // START USER SETTERS
    
    func setUserID(newUserID : Int) {
        userID = newUserID
    }
    
    func setUsername(newUsername : String) {
        username = newUsername
    }
    
    func setUserPassword(newUserPassword : String) {
        userPassword = newUserPassword
    }
    
    func setUserAboutMe(newUserAboutMe : String) {
        userAboutMe = newUserAboutMe
    }
    
    func setUserEmailAddress(newUserEmailAddress : String) {
        userEmailAddress = newUserEmailAddress
    }
    
    func setUserPhoneNumber(newUserPhoneNumber : String) {
        userPhoneNumber = newUserPhoneNumber
    }
    
    func setUserIsVerified(newUserVerificationStatus : Bool) {
        userIsVerified = newUserVerificationStatus
    }
    
    // END USER SETTERS
    
    // BEGIN USER GETTERS
    
    func getUserID() {
        print(userID)
    }
    
    func getUserName() {
        print(username)
    }
    
    func getUserPassword() {
        print(userPassword)
    }
    
    func getUserAboutMe() {
        print(userAboutMe)
    }
    
    func getUserPhoneNumber() {
        print(userPhoneNumber)
    }
    
    func getUserIsVerified() {
        print(userIsVerified)
    }
    
    // END USER GETTERS
}
