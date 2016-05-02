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
    "login_teacherLogin",
    "login_studentLogout",
    "login_teacherLogout",
    "login_studentChangePassword"
]

var AttendanceService = [
    "attendance_studentAttendance",
    "attendance_teacherGetCourseClasses",
    "attendance_teacherBeginClass",
    "attendance_getAttendanceInfosByTeacherID",
    "attendance_getAttendanceDetailInfo",
    "attendance_updateStudentAttendanceInfos"
]

var LeaveService = [
    "leave_studentGetCourseClasses",
    "leave_leaveApplication",
    "leave_getLeaveInfosByStudentID",
    "leave_getLeaveDetailByLeaveID",
    "leave_getLeaveInfosByTeacherID",
    "leave_checkApplication"
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
    static let login_studentLogout = "login_studentLogout"
    static let login_teacherLogout = "login_teacherLogout"
    static let login_studentChangePassword  = "login_studentChangePassword"
    
    
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
    //教师批量修改学生考勤信息
    static let attendance_updateStudentAttendanceInfos = "attendance_updateStudentAttendanceInfos"
    
    // 请假模块
    // 学生获取课程表
    static let leave_studentGetCourseClasses = "leave_studentGetCourseClasses"
    // 学生发起请假
    static let leave_leaveApplication = "leave_leaveApplication"
    // 学生获取历史请假列表
    static let leave_getLeaveInfosByStudentID = "leave_getLeaveInfosByStudentID"
    // 学生、教师获取请假明细
    static let leave_getLeaveDetailByLeaveID = "leave_getLeaveDetailByLeaveID"
    // 教师获取请假列表
    static let leave_getLeaveInfosByTeacherID = "leave_getLeaveInfosByTeacherID"
    // 教师审核请假单
    static let leave_checkApplication = "leave_checkApplication"
    
    
    class func getServiceMethod() -> [String:AnyObject] {
        let serviceMethods =
            ["LoginController":LoginService,
             "LeaveController":LeaveService,
             "AttendanceController":AttendanceService,
             "TestController":TestService]
        return serviceMethods
    }
}
