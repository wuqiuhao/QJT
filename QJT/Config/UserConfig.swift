//
//  UserConfig.swift
//  QJT
//
//  Created by LZQ on 16/4/17.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

class UserConfig: NSObject {
    /**
     判断是否登录
     
     */
    class func isLogined() -> Bool {
        if let userID = UserConfig.studentSetting()?.userID where userID.characters.count != 0 {
            return true
        } else if let userID = UserConfig.teacherSetting()?.userID where userID.characters.count != 0 {
            return true
        }
        return false
    }
    
    /**
     保存最后的用户名
     
     - parameter username: userName
     */
    class func saveLastUsername(userName: String) {
        NSUserDefaults.standardUserDefaults().setValue(userName, forKey: "lastUserName")
    }
    
    /**
     读取最后的用户名
     
     - returns: userName
     */
    class func lastUsername() -> String? {
        return NSUserDefaults.standardUserDefaults().valueForKey("lastUserName") as? String
    }
    
    /**
     保存学生信息
     
     - parameter StudentSetting
     */
    class func saveStudentSetting(studentSetting: StudentSetting) {
        let documents = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as [String]
        let document = documents.last! as NSString
        let path = document.stringByAppendingPathComponent("StudentSetting.archiver")
        NSKeyedArchiver.archiveRootObject(studentSetting, toFile: path)
    }
    
    
    /**
     读取学生信息
     
     - returns: 返回 StudentSetting Model
     */
    class func studentSetting() -> StudentSetting? {
        let documents = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as [String]
        let document = documents.last! as NSString
        let path = document.stringByAppendingPathComponent("StudentSetting.archiver")
        if let archiverStudentSetting = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? StudentSetting {
            return archiverStudentSetting
        }
        return nil
    }
    
    /**
     保存教师信息
     
     - parameter TeacherSetting
     */
    class func saveTeacherSetting(teacherSetting: TeacherSetting) {
        let documents = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as [String]
        let document = documents.last! as NSString
        let path = document.stringByAppendingPathComponent("TeacherSetting.archiver")
        NSKeyedArchiver.archiveRootObject(teacherSetting, toFile: path)
    }
    
    /**
     读取教师信息
     
     - returns: TeacherSetting Model
     */
    class func teacherSetting() -> TeacherSetting? {
        let documents = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as [String]
        let document = documents.last! as NSString
        let path = document.stringByAppendingPathComponent("TeacherSetting.archiver")
        if let archiverTeacherSetting = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? TeacherSetting {
            return archiverTeacherSetting
        }
        return nil
    }
    
    /**
     删除所有沙盒内的文件
     
     - returns: 是否成功
     */
    class func removeAllFileInSandbox() -> Bool {
        let fileManager = NSFileManager()
        let documents = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as [String]
        let document = documents.last! as NSString
        var userInfoPath = ""
        if let userID = UserConfig.studentSetting()?.userID where userID.characters.count != 0 {
            userInfoPath = document.stringByAppendingPathComponent("StudentSetting.archiver")
        } else if let userID = UserConfig.teacherSetting()?.userID where userID.characters.count != 0 {
            userInfoPath = document.stringByAppendingPathComponent("TeacherSetting.archiver")
        }
        let pathArr = [userInfoPath]
        for path in pathArr {
            if fileManager.fileExistsAtPath(path) {
                do {
                    try fileManager.removeItemAtPath(path)
                    return true
                } catch let error as NSError {
                    debugPrint("删除文件: \(path) 失败 error: \(error)")
                    return false
                }
            } else {
                debugPrint("读取文件: \(path) 失败")
                return false
            }
        }
        return true
    }

    
    
}