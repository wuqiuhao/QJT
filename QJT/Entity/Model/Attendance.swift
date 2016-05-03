//
//  Attendance.swift
//  QJT
//
//  Created by YC on 16/4/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

class Attendance: Mappable {
    
    // 点名编号
    var attendanceID: Int
    // 课程班级编号
    var courseClassID: String
    // 开始时间
    var attendanceTime: NSDate
    // 教师编号
    var teacherID: String
    // 班级名称
    var className: String
    // 课程名称
    var courseName: String
    // 缺课次数
    var quekeCount: Int
    // 迟到次数
    var chidaoCount: Int
    // 早退次数
    var zaotuiCount: Int
    // 请假次数
    var qingjiaCount: Int
    // 是否可修改
    var modified: Bool
    // 更新时间
    var updateTime: NSDate
    // 经度
    var longitude: Double
    // 维度
    var latitude: Double
    // 教师姓名
    var teacherName: String
    
    
    init() {
        attendanceID = 0
        courseClassID = ""
        attendanceTime = NSDate()
        teacherID = ""
        className = ""
        courseName = ""
        quekeCount = 0
        chidaoCount = 0
        zaotuiCount = 0
        qingjiaCount = 0
        modified = true
        updateTime = NSDate()
        longitude = 0.0
        latitude = 0.0
        teacherName = ""
        
    }
    
    required init?(_ map: Map) {
        attendanceID = 0
        courseClassID = ""
        attendanceTime = NSDate()
        teacherID = ""
        
        className = ""
        courseName = ""
        quekeCount = 0
        chidaoCount = 0
        
        zaotuiCount = 0
        qingjiaCount = 0
        modified = true
        updateTime = NSDate()
        
        longitude = 0.0
        latitude = 0.0
        teacherName = ""
        
    }
    func mapping(map: Map) {
        attendanceID   <- map["attendanceID"]
        courseClassID  <- map["courseClassID"]
        attendanceTime <- map["attendanceTime"]
        teacherID      <- map["teacherID"]
        
        className      <- map["className"]
        courseName     <- map["courseName"]
        quekeCount     <- map["quekeCount"]
        chidaoCount    <- map["chidaoCount"]
        
        zaotuiCount    <- map["zaotuiCount"]
        qingjiaCount   <- map["qingjiaCount"]
        modified       <- map["modified"]
        updateTime     <- (map["updateTime"],QJTDateTransform())
        
        longitude      <- map["longitude"]
        latitude       <- map["latitude"]
        
        teacherName    <- map["teacherName"]
        
    }
    
}