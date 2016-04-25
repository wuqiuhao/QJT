//
//  StudentSetting.swift
//  QJT
//
//  Created by LZQ on 16/4/20.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

class StudentSetting: PersonSetting, NSCoding {
    
    // 入学年份
    var schoolYear: Int
    // 班级名称
    var className: String
    // 专业名称
    var specialityName: String
    // 设备ID
    var deviceID: String
    
    override init() {
        schoolYear = 0
        className = ""
        specialityName = ""
        deviceID = ""
        super.init()
    }
    
    required init?(_ map: Map) {
        schoolYear = 0
        className = ""
        specialityName = ""
        deviceID = ""
        super.init(map)
    }
    
    override func mapping(map: Map) {
        schoolYear      <- map["schoolYear"]
        className       <- map["className"]
        specialityName  <- map["specialityName"]
        deviceID        <- map["deviceID"]
        super.mapping(map)
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(userID, forKey: "userID")
        aCoder.encodeObject(userName, forKey: "userName")
        aCoder.encodeObject(phoneNum, forKey: "phoneNum")
//        aCoder.encodeInteger(userType, forKey: "userType")
        aCoder.encodeInteger(portraitID, forKey: "portraitID")
        aCoder.encodeInteger(schoolYear, forKey: "schoolYear")
        aCoder.encodeObject(className, forKey: "className")
        aCoder.encodeObject(specialityName, forKey: "specialityName")
        aCoder.encodeObject(deviceID, forKey: "deviceID")
        aCoder.encodeObject(appMenus, forKey: "appMenus")
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        schoolYear = aDecoder.decodeIntegerForKey("schoolYear")
        className = aDecoder.decodeObjectForKey("className") as! String
        specialityName = aDecoder.decodeObjectForKey("specialityName") as! String
        deviceID = aDecoder.decodeObjectForKey("deviceID") as! String
        super.init()
        userID = aDecoder.decodeObjectForKey("userID") as! String
        userName = aDecoder.decodeObjectForKey("userName") as! String
        phoneNum = aDecoder.decodeObjectForKey("phoneNum") as! String
//        userType = aDecoder.decodeIntegerForKey("userType")
        portraitID = aDecoder.decodeIntegerForKey("portraitID")
        appMenus = aDecoder.decodeObjectForKey("appMenus") as! [AppMenu]
    }
    
    
}