//
//  CourseClass.swift
//  QJT
//
//  Created by LZQ on 16/4/24.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

class CourseClass: Mappable {
    
    // 课程班级唯一编号
    var courseClassUniqueID: Int
    
    // 课程班级编号
    var courseClassID: String
    // 课程名
    var courseName: String
    // 上课地点
    var address: String
    // 课程编号
    var courseID: String
    // 上课时间
    var courseTime: NSDate
    // 星期几
    var week: Week
    // 第几节开始
    var fromSection: Int
    // 持续几节
    var durationSection: Int
    // 学期
    var semester: Int
    // 学年
    var year: Int
    // 教师姓名
    var teacherName: String
    // 班级名称
    var className: String
    
    init() {
        courseClassID = ""
        courseName = ""
        address = ""
        courseID = ""
        courseTime = NSDate()
        week = Week.Unknown
        fromSection = 0
        durationSection = 0
        semester = 0
        year = 0
        teacherName = ""
        className = ""
        courseClassUniqueID = 0
    }
    
    required init?(_ map: Map) {
        courseClassID = ""
        courseName = ""
        address = ""
        courseID = ""
        courseTime = NSDate()
        week = Week.Unknown
        fromSection = 0
        durationSection = 0
        semester = 0
        year = 0
        teacherName = ""
        className = ""
        courseClassUniqueID = 0
    }
    
    func mapping(map: Map) {
        courseClassID       <- map["courseClassID"]
        courseName          <- map["courseName"]
        address             <- map["address"]
        courseID            <- map["courseID"]
        courseTime          <- map["courseTime"]
        week                <- map["week"]
        fromSection         <- map["fromSection"]
        durationSection     <- map["durationSection"]
        semester            <- map["semester"]
        year                <- map["year"]
        teacherName         <- map["teacherName"]
        className           <- map["className"]
        courseClassUniqueID <- map["courseClassUniqueID"]
    }
}