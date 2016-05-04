//
//  NotificationHandler.swift
//  QJT
//
//  Created by LZQ on 16/5/4.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

class NotificationHandler {
    
    static func fetchAPNsNotificationForInActive(userInfo: [NSObject : AnyObject]) {
        
        let mainTabVC = UIApplication.sharedApplication().delegate!.window!!.rootViewController as! MainTabBarController
        let naviVC = mainTabVC.viewControllers![mainTabVC.selectedIndex]
        let pushVC = (naviVC as! UINavigationController).topViewController

        if let userID = UserConfig.studentSetting()?.userID where userID.characters.count != 0 {
            let vc = UIStoryboard(name: "SPersonal", bundle: nil).instantiateViewControllerWithIdentifier("SPersonalLNDetailViewController") as! SPersonalLNDetailViewController
            vc.leaveID = Int(userInfo["leaveID"] as! String)
            pushVC?.navigationController?.pushViewController(vc, animated: true)
            
        } else if let userID = UserConfig.teacherSetting()?.userID where userID.characters.count != 0 {
            switch UserConfig.teacherSetting()!.userType {
            case .CourseTeacher:
                print("任课老师点击进入APP")
            default:
                let vc = UIStoryboard(name: "CLTLeave", bundle: nil).instantiateViewControllerWithIdentifier("CLTLeaveDetailViewController") as! CLTLeaveDetailViewController
                vc.leaveID = Int(userInfo["leaveID"] as! String)
                pushVC?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    static func fetchAPNsNotificationForActive(userInfo: [NSObject: AnyObject]) {
        
        let vc = UIApplication.sharedApplication().keyWindow!.rootViewController!
        let alertController = UIAlertController(title: nil, message: userInfo["context"] as? String, preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(cancelAction)
        vc.presentViewController(alertController, animated: true, completion: nil)

        
    }
    
}