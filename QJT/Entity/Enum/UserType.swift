//
//  UserType.swift
//  QJT
//
//  Created by LZQ on 16/4/17.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

@objc
enum UserType: Int,BaseType {
    case Unknown
    case Student //学生
    case ClassTeacher //班主任
    case Teacher //任课教师
    case Counsellor //辅导员
    case BranchLeader //分院领导
    case Leader  // 学院领导
    case StudentWorker //学工教师
    
    
    func toString() -> String {
        switch self {
        case .Unknown:
            return "未知"
        case .Student:
            return "学生"
        case .ClassTeacher:
            return "班主任"
        case .Teacher:
            return "任课教师"
        case .Counsellor:
            return "辅导员"
        case .BranchLeader:
            return "分院领导"
        case .Leader:
            return "学院领导"
        case .StudentWorker:
            return "学工教师"
        }
    }
    
    func toInt() -> Int {
        return self.rawValue
    }
    
    func fromString(value : String) -> Int {
        switch value {
        case "Unknown" :
            return UserType.Unknown.rawValue
        case "Student" :
            return UserType.Student.rawValue
        case "classTeacher" :
            return UserType.ClassTeacher.rawValue
        case "Teacher" :
            return UserType.Teacher.rawValue
        case "Counsellor":
            return UserType.Counsellor.rawValue
        case "BranchLeader":
            return UserType.BranchLeader.rawValue
        case "Leader":
            return UserType.Leader.rawValue
        case "StudentWorker":
            return UserType.StudentWorker.rawValue
        default :
            return UserType.Unknown.rawValue
        }
        
    }
    
    func parseString<T>(value : String) -> T {
        return UserType(rawValue: self.fromString(value)) as! T
    }
    
    func toDescription() -> String {
        switch self {
        case .Unknown:
            return "未知"
        case .Student:
            return "学生"
        case .ClassTeacher:
            return "班主任"
        case .Teacher:
            return "任课教师"
        case .Counsellor:
            return "辅导员"
        case .BranchLeader:
            return "分院领导"
        case .Leader:
            return "学院领导"
        case .StudentWorker:
            return "学工教师"
        }
    }
    
}