//
//  Member.swift
//  wechatClone
//
//  Created by Yilei Huang on 2021-09-16.
//

import SwiftUI

struct Member:Hashable{
    var name,uid,email:String?
    var registerType:String?

    init(dictionary:[String:Any]) {
//        self.timeCreated = dictionary["timeCreated"] as? Timestamp
        self.name = dictionary["userName"] as? String
        self.uid = dictionary["uid"] as? String
        self.email = dictionary["email"] as? String
        self.registerType = dictionary["registerType"] as? String
    }
}
