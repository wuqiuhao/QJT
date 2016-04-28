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
        aCoder.encodeObject(userType.toString(), forKey: "userType")
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
        switch  aDecoder.decodeObjectForKey("userType") as! String {
        case "Uknown":
            userType = UserType.Unknown
        case "Student":
            userType = UserType.Student
        case "Teacher":
            userType = UserType.Teacher
        case "CourseTeacher":
            userType = UserType.CourseTeacher
        case "ClassTeacher":
            userType = UserType.ClassTeacher
        case "Counsellor":
            userType = UserType.Counsellor
        case "BranchLeader":
            userType = UserType.BranchLeader
        case "Leader":
            userType = UserType.Leader
        case "StudentWorker":
            userType = UserType.StudentWorker
        default:
            userType = UserType.Unknown
        }
        portraitID = aDecoder.decodeIntegerForKey("portraitID")
        appMenus = aDecoder.decodeObjectForKey("appMenus") as! [AppMenu]
    }
    
}