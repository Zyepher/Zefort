//
//  User.swift
//  Zefort
//
//  Created by NIK FIKRI on 21/06/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import Foundation

class User {
    
    private var _email: String
    private var _name: String
    private var _about: String
    private var _joinedDate: String
    
    private var _isTutor: Bool
    private var _isExcellentTutor: Bool
    private var _isVerified: Bool
    
    private var _provider: String
    
    var email: String {
        return _email
    }
    
    var name: String {
        return _name
    }
    
    var about: String {
        return _about
    }
    
    var joinedDate : String {
        return _joinedDate
    }
    
    var isTutor: Bool {
        return _isTutor
    }
    
    var isExcellentTutor: Bool {
        return _isExcellentTutor
    }
    
    var isVerified: Bool {
        return _isVerified
    }
    
    var provider: String {
        return _provider
    }
    
    init(email: String, name: String, about: String, joinedDate: String, isTutor: Bool, isExcellentTutor: Bool, isVerified: Bool, provider: String) {
        self._email = email
        self._name = name
        self._about = about
        self._joinedDate = joinedDate
        self._isTutor = isTutor
        self._isExcellentTutor = isExcellentTutor
        self._isVerified = isVerified
        self._provider = provider
    }
    
}
