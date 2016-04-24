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
    
    // 课程班级编号
    var courseClassID: Int
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
    
    init() {
        courseClassID = 0
        address = ""
        courseID = ""
        courseTime = NSDate()
        week = Week.Unknown
        fromSection = 0
        durationSection = 0
        semester = 0
        year = 0
    }
    
    required init?(_ map: Map) {
        courseClassID = 0
        address = ""
        courseID = ""
        courseTime = NSDate()
        week = Week.Unknown
        fromSection = 0
        durationSection = 0
        semester = 0
        year = 0
    }
    
    func mapping(map: Map) {
        courseClassID       <- map["courseClassID"]
        address             <- map["address"]
        courseID            <- map["courseID"]
        courseTime          <- map["courseTime"]
        week                <- map["week"]
        fromSection         <- map["fromSection"]
        durationSection     <- map["durationSection"]
        semester            <- map["semester"]
        year                <- map["year"]
    }
}