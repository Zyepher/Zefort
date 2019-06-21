//
//  AuthService.swift
//  XAROUND
//
//  Created by NIK FIKRI on 06/06/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
    
            DataService.instance.createDBUser(uid: user.user.uid, userEmail: user.user.email!, userName: "Zyepher", userAbout: "I love coding!", userJoinedDate: "Member since January 2019", userIsTutor: false, userIsExcellentTutor: false, userIsVerified: false, provider: user.user.providerID)
            
            userCreationComplete(true, nil)
        }
    }
    
    func signinUser(withEmail email: String, andPassword password: String, signinComplete: @escaping (_ status : Bool, _ error : Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                signinComplete(false, error)
                return
            }
            signinComplete(true, nil)
        }
    }
}


