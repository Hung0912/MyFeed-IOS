//
//  Post.swift
//  Feed_v1
//
//  Created by HungPB on 7/1/19.
//  Copyright © 2019 HungPB. All rights reserved.
//

import Foundation
import UIKit

struct Post {
    var poster: Poster
    var statusText : String
    var postImage : UIImage?
    var like : Int
    var comment : Int
    
    var postTime : Date?
    
    var hasLiked = false
    
    init(poster: Poster, statusText: String , postImage: UIImage?, createDate: Date) {
        self.poster = poster
        self.like = 0
        self.comment = 0
        self.statusText = statusText
        self.postTime = createDate
        self.postImage = postImage
    }
    
}
