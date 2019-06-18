//
//  Community.swift
//  XAROUND
//
//  Created by NIK FIKRI on 07/02/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import Foundation

class Question {
    
    private var _email: String
    private var _questionDescription: String
    private var _members: [String]
    private var _key: String
    private var _status: Bool
    
    
    var email: String {
        return _email
    }
    
    var questionDescription: String {
        return _questionDescription
    }
    
    var key: String {
        return _key
    }
    
    var status: Bool {
        return _status
    }
    
    init(email: String, description: String, members: [String], key: String, status: Bool) {
        self._email = email
        self._questionDescription = description
        self._members = members
        self._key = key
        self._status = status
    }
    
}
