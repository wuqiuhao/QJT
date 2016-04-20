//
//  Student.swift
//  QJT
//
//  Created by wuqiuhao on 16/3/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

class Student: Mappable {
    // 学生学号
    var studentID: String
    // 登录密码
    var password: String
    // 学生姓名
    var name: String
    // 联系方式
    var phoneNum: String
    // 专业编号
    var specialtyID: Int
    // 入学年份
    var schoolYear: Int
    // 头像编号
    var protraitID: Int
    // 班级名称
    var className: String
    
    init(){
        studentID = ""
        password = ""
        name = ""
        phoneNum = ""
        specialtyID = 0
        schoolYear = 0
        protraitID = 0
        className = ""
    }
    
    required init?(_ map: Map) {
        studentID = ""
        password = ""
        name = ""
        phoneNum = ""
        specialtyID = 0
        schoolYear = 0
        protraitID = 0
        className = ""
    }
    
    
    // Mappable
    func mapping(map: Map) {
        studentID       <- map["studentID"]
        password        <- map["password"]
        name            <- map["name"]
        phoneNum        <- map["phoneNum"]
        specialtyID     <- map["specialtyID"]
        schoolYear      <- map["schoolYear"]
        protraitID      <- map["protraitID"]
        className       <- map["className"]
    }
}