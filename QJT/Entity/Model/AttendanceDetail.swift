//
//  AttendanceDetail.swift
//  QJT
//
//  Created by YC on 16/4/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

class AttendanceDetail: Mappable {
    
    //点名明细编号
    var attendanceDetailID: Int
    //点名编号
    var attendanceID: Int
    //学生编号
    var studentID: String
    //学生姓名
    var studentName: String
    //缺课次数
    var queke: Int
    //迟到次数
    var chidao: Int
    //早退次数
    var zaotui: Int
    //请假次数
    var qingjia: Int
    
    init() {
        attendanceDetailID = 0
        attendanceID = 0
        studentID = ""
        studentName = ""
        queke = 0
        chidao = 0
        zaotui = 0
        qingjia = 0
    }
    
    required init?(_ map: Map) {
        attendanceDetailID = 0
        attendanceID = 0
        studentID = ""
        studentName = ""
        queke = 0
        chidao = 0
        zaotui = 0
        qingjia = 0
    }
    
    func mapping(map: Map) {
        attendanceDetailID <- map["attendanceDetailID"]
        attendanceID       <- map["attendanceID"]
        studentID          <- map["studentID"]
        studentName        <- map["studentName"]
        queke              <- map["queke"]
        chidao             <- map["chidao"]
        zaotui             <- map["zaotui"]
        qingjia            <- map["qingjia"]
    }
    
    
}
