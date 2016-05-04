//
//  studentAttendanceInfo.swift
//  QJT
//
//  Created by YC on 16/5/2.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

class StudentAttendanceInfo: Mappable {
    
    var courseName: String
    var attendanceTime: NSDate
    var teacherName: String
    var chidao: Int
    var zaotui: Int
    var qingjia: Int
    var queke: Int
    
    init() {
        
        courseName = ""
        attendanceTime = NSDate()
        teacherName = ""
        chidao = 0
        zaotui = 0
        qingjia = 0
        queke = 0
        
    }
    
    required init?(_ map: Map) {
        
        courseName = ""
        attendanceTime = NSDate()
        teacherName = ""
        chidao = 0
        zaotui = 0
        qingjia = 0
        queke = 0
        
    }
    
    func mapping(map: Map) {
        
        courseName     <- map["courseName"]
        attendanceTime <- (map["attendanceTime"],QJTDateTransform())
        teacherName    <- map["teacherName"]
        chidao         <- map["chidao"]
        zaotui         <- map["zaotui"]
        qingjia        <- map["qingjia"]
        queke          <- map["queke"]
        
    }
    
}