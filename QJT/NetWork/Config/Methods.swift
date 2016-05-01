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
    "attendance_getAttendanceInfosByTeacherID",
    "attendance_getAttendanceDetailInfo"
]

var LeaveService = [
    "leave_studentGetCourseClasses",
    "leave_leaveApplication",
    "leave_getLeaveInfosByStudentID"
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
    //教师获取考勤明细
    static let attendance_getAttendanceDetailInfo = "attendance_getAttendanceDetailInfo"
    
    
    // 请假模块
    // 学生获取课程表
    static let leave_studentGetCourseClasses = "leave_studentGetCourseClasses"
    // 学生发起请假
    static let leave_leaveApplication = "leave_leaveApplication"
    // 学生获取历史请假列表
    static let leave_getLeaveInfosByStudentID = "leave_getLeaveInfosByStudentID"
    
    
    class func getServiceMethod() -> [String:AnyObject] {
        let serviceMethods =
            ["LoginController":LoginService,
             "LeaveController":LeaveService,
             "AttendanceController":AttendanceService,
             "TestController":TestService]
        return serviceMethods
    }
}
