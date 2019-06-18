//
//  bpPost.swift
//  XAROUND
//
//  Created by NIK FIKRI on 07/06/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import Foundation

class Post {
    
    private var _content: String
    private var _senderID: String
    
    var content: String {
        return _content
    }
    
    var senderID: String {
        return _senderID
    }
    
    init(content: String, senderID: String) {
        self._content = content
        self._senderID = senderID
    }
    
}
