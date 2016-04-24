//
//  MainTabBarController.swift
//  QJT
//
//  Created by LZQ on 16/4/13.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    var vcArray = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBar()
    }

}

// MARK: - private Method
extension MainTabBarController {
    
    func configTabBar() {
        tabBar.tintColor = UIColor.qjtTintColor()
        for tabMenu in UserConfig.studentSetting()!.appMenus {
            let item = UITabBarItem(title: tabMenu.menuName, image: UIImage(named: "main_\(tabMenu.uniqueCode)_normal"), selectedImage: UIImage(named: "main_\(tabMenu.uniqueCode)_select"))
            let vc: UIViewController?
            switch tabMenu.uniqueCode {
            // 请假模块
            case "leave":
                vc = UIStoryboard(name: "Leave", bundle: nil).instantiateInitialViewController()
            // 教师考勤
            case "attendance":
                vc = UIStoryboard(name: "Attendance", bundle: nil).instantiateInitialViewController()
            // 学生签到
            case "sign":
                vc = UIStoryboard(name: "Sign", bundle: nil).instantiateInitialViewController()
            // 我的模块
            case "personal":
                vc = UIStoryboard(name: "Personal", bundle: nil).instantiateInitialViewController()
            default:
                return
            }
            vc!.tabBarItem = item
            vcArray.append(vc!)
        }
        self.viewControllers = vcArray
    }
}