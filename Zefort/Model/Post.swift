//
//  Post.swift
//  XAROUND
//
//  Created by NIK FIKRI on 14/03/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import Foundation

class Post {
    
    //TODO: Posts need a senderUsername and a postBody variable
    var postSender : String = ""
    var postBody : String = ""
    
    //TODO: Variables to count the react for different types of reactions.
    var reactLike : Int = 0
    var reactLove : Int = 0
    var reactWow : Int = 0
    var reactHype : Int = 0
    var reactHaha : Int = 0
    var reactSad : Int = 0
    
    //TODO: Setters
    func setPostBody(writtenPostBody : String) {
        postBody = writtenPostBody
    }
}
