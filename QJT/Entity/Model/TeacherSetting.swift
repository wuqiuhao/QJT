//
//  TeacherSetting.swift
//  QJT
//
//  Created by LZQ on 16/4/20.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

class TeacherSetting: PersonSetting, NSCoding {
    
    // 职称
    var title: String
    // 学历
    var qualification: String
    // 简介
    var brief: String
    
    
    override init() {
        title = ""
        qualification = ""
        brief = ""
        super.init()
    }
    
    required init?(_ map: Map) {
        title = ""
        qualification = ""
        brief = ""
        super.init(map)
    }
    
    override func mapping(map: Map) {
        title           <- map["title"]
        qualification   <- map["qualification"]
        brief           <- map["brief"]
        super.mapping(map)
    }
    
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(userID, forKey: "userID")
        aCoder.encodeObject(userName, forKey: "userName")
        aCoder.encodeObject(phoneNum, forKey: "phoneNum")
//        aCoder.encodeInteger(userType, forKey: "userType")
        aCoder.encodeInteger(portraitID, forKey: "portraitID")
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(qualification, forKey: "qualification")
        aCoder.encodeObject(brief, forKey: "brief")
        aCoder.encodeObject(appMenus, forKey: "appMenus")
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObjectForKey("title") as! String
        qualification = aDecoder.decodeObjectForKey("qualification") as! String
        brief = aDecoder.decodeObjectForKey("brief") as! String
        super.init()
        userID = aDecoder.decodeObjectForKey("userID") as! String
        userName = aDecoder.decodeObjectForKey("userName") as! String
        phoneNum = aDecoder.decodeObjectForKey("phoneNum") as! String
//        userType = aDecoder.decodeIntegerForKey("userType")
        portraitID = aDecoder.decodeIntegerForKey("portraitID")
        appMenus = aDecoder.decodeObjectForKey("appMenus") as! [AppMenu]
    }
    
}