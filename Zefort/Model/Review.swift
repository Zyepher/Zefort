//
//  Review.swift
//  Zefort
//
//  Created by NIK FIKRI on 21/06/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import Foundation

class Review {
    
    private var _name: String
    private var _content: String
    private var _month: String
    private var _memberSince: String
    
    var name: String {
        return _name
    }
    
    var content: String {
        return _content
    }
    
    var month: String {
        return _month
    }
    
    var memberSince: String {
        return _memberSince
    }
    
    init(name: String, content: String, month: String, memberSince: String) {
        self._name = name
        self._content = content
        self._month = month
        self._memberSince = memberSince
    }
    
}
