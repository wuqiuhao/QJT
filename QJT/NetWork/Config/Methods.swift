//
//  Method.swift
//  QJT
//
//  Created by wuqiuhao on 16/3/29.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

var LoginService = [
    "login_studentLogin",
    "login_teacherLogin"
]

var AttendanceService = [
    "attendance_studentAttendance",
    "attendance_teacherGetCourseClasses",
    "attendance_teacherBeginClass",
    "attendance_getAttendanceInfosByTeacherID"
]

var LeaveService = [
    "leave_studentGetCourseClasses"
]

var TestService = [
    "test"
]

class Methods {
    // 数据测试接口
    static let test = "test"
    // 登陆模块
    // 学生登录
    static let login_studentLogin = "login_studentLogin"
    static let login_teacherLogin = "login_teacherLogin"
    
    //签到模块
    //学生签到
    static let attendance_studentAttendance = "attendance_studentAttendance"
    //教师获取课程表
    static let attendance_teacherGetCourseClasses = "attendance_teacherGetCourseClasses"
    //教师发起考勤
    static let attendance_teacherBeginClass = "attendance_teacherBeginClass"
    //教师获取所有考勤列表
    static let attendance_getAttendanceInfosByTeacherID = "attendance_getAttendanceInfosByTeacherID"
    
    // 请假模块
    // 学生获取课程表
    static let leave_studentGetCourseClasses = "leave_studentGetCourseClasses"
    
    
    
    class func getServiceMethod() -> [String:AnyObject] {
        let serviceMethods =
            ["LoginController":LoginService,
             "LeaveController":LeaveService,
             "AttendanceController":AttendanceService,
             "TestController":TestService]
        return serviceMethods
    }
}
