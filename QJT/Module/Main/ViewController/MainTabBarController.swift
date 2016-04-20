//
//  MainTabBarController.swift
//  QJT
//
//  Created by LZQ on 16/4/13.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTabBar()
        
    }

}

// MARK: - private Method
extension MainTabBarController {
    
    func configTabBar() {
        
        tabBar.tintColor = UIColor.qjtTintColor()
        
        let leaveItem = UITabBarItem(title: "请假", image: UIImage(named: "main_leave_normal"), selectedImage: UIImage(named: "main_leave_select"))
        let leaveVC = UIStoryboard(name: "Leave", bundle: nil).instantiateInitialViewController() as! UINavigationController
        leaveVC.tabBarItem = leaveItem
        
        let attendanceItem = UITabBarItem(title: "考勤", image: UIImage(named: "main_attendance_normal"), selectedImage: UIImage(named: "main_attendance_select"))
        let attendanceVC = UIStoryboard(name: "Attendance", bundle: nil).instantiateInitialViewController() as! UINavigationController
        attendanceVC.tabBarItem = attendanceItem
        
        let personalItem = UITabBarItem(title: "我的", image: UIImage(named: "main_personal_normal"), selectedImage: UIImage(named: "main_personal_select"))
        let personalVC = UIStoryboard(name: "Personal", bundle: nil).instantiateInitialViewController() as! UINavigationController
        personalVC.tabBarItem = personalItem
        
        viewControllers = [leaveVC,attendanceVC,personalVC]
        
        
        
    }
    
    
}