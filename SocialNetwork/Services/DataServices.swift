//
//  DataServices.swift
//  SocialNetwork
//
//  Created by Daud Arifi on 24.11.17.
//  Copyright © 2017 Daud Arifi. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE_ = DB_BASE
    private var _REF_POSTS_ = DB_BASE.child("posts")
    private var _REF_USERS_ = DB_BASE.child("users")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE_
    }
    
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS_
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS_
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}




