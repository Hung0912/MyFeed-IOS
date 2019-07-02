//
//  Acount.swift
//  Feed_v1
//
//  Created by HungPB on 7/1/19.
//  Copyright © 2019 HungPB. All rights reserved.
//

import Foundation

struct Poster {
    var name : String?
    var address : String?
    var birthdate : String?
    var avatar: String?
    
    init(name: String, address: String, birthdate: String, avatar: String) {
        self.name = name
        self.address = address
        self.birthdate = birthdate
        self.avatar = avatar
    }
}
