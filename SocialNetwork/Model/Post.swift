//
//  Post.swift
//  SocialNetwork
//
//  Created by Daud Arifi on 27.11.17.
//  Copyright © 2017 Daud Arifi. All rights reserved.
//

import Foundation

class Post {
    private var _caption: String!
    private var _ImageURL: String!
    private var _likes: Int!
    private var _postKEY: String!

    var caption: String {
        return _caption
    }
    
    var imageURL: String {
        return _ImageURL
    }
    
    var likes: Int {
        return _likes
    }
    
    var postKEY: String {
        return _postKEY
    }

    init(caption: String, imageURL: String, likes: Int) {
        self._caption = caption
        self._ImageURL = imageURL
        self._likes = likes
    }

    init(postKEY: String, postData: Dictionary<String, AnyObject>) {
        self._postKEY = postKEY
    
        if let caption = postData["caption"] as? String {
            self._caption = caption
    }
        if let imageURL = postData["imageUrl"] as? String {
            self._ImageURL = imageURL
    }
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
    }
}
