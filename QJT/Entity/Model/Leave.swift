//
//  Leave.swift
//  QJT
//
//  Created by LZQ on 16/4/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

class Leave: Mappable {
    
    // 请假编号
    var leaveID: Int
    // 学生编号
    var studentID: String
    // 学生姓名
    var studentName: String
    // 班级名称
    var className: String
    // 开始时间
    var fromTime: NSDate
    // 截止时间
    var toTime: NSDate
    // 是否通过
    var leaveState: LeaveState
    // 请假原因
    var reason: String
    // 教师编号
    var teacherID: String
    // 教师姓名
    var teacherName: String
    // 请假课程编号数组
    var leaveCourses: [String]
    // 学年
    var year: Int
    // 学期
    var semester: Int
    // 拒绝理由
    var refuseReason: String
    
    init() {
        leaveID = 0
        studentID = ""
        studentName = ""
        className = ""
        fromTime = NSDate()
        toTime = NSDate()
        leaveState = LeaveState.Unknown
        reason = ""
        teacherID = ""
        teacherName = ""
        leaveCourses = [String]()
        year = 0
        semester = 0
        refuseReason = ""
    }
    
    required init?(_ map: Map) {
        leaveID = 0
        studentID = ""
        studentName = ""
        className = ""
        fromTime = NSDate()
        toTime = NSDate()
        leaveState = LeaveState.Unknown
        reason = ""
        teacherID = ""
        teacherName = ""
        leaveCourses = [String]()
        year = 0
        semester = 0
        refuseReason = ""
    }
    
    func mapping(map: Map) {
        leaveID         <- map["leaveID"]
        studentID       <- map["studentID"]
        studentName     <- map["studentName"]
        className       <- map["className"]
        fromTime        <- map["fromTime"]
        toTime          <- map["toTime"]
        leaveState      <- map["leaveState"]
        reason          <- map["reason"]
        teacherID       <- map["teacherID"]
        teacherName     <- map["teacherName"]
        leaveCourses    <- map["leaveCourses"]
        year            <- map["year"]
        semester        <- map["semester"]
        refuseReason    <- map["refuseReason"]
    }
    
}