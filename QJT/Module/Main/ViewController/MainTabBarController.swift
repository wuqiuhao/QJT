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
    var userType: UserType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBar()
    }
    
}

// MARK: - private Method
extension MainTabBarController {
    
    func configTabBar() {
        tabBar.tintColor = UIColor.qjtTintColor()
        
        let appMenus: [AppMenu]!
        if userType == .Student {
            appMenus = UserConfig.studentSetting()!.appMenus
        } else {
            appMenus = UserConfig.teacherSetting()!.appMenus
        }
        for tabMenu in appMenus {
            let item = UITabBarItem(title: tabMenu.menuName, image:  UIImage(named: "main_\(tabMenu.uniqueCode)_normal"), selectedImage: UIImage(named: "main_\(tabMenu.uniqueCode)_normal"))
            let vc: UIViewController?
            let abbr = userType.ToAbbreviate()
            switch tabMenu.uniqueCode {
            case "leave":
                vc = UIStoryboard(name: "\(abbr)Leave", bundle: nil).instantiateInitialViewController()
            case "attendance":
                vc = UIStoryboard(name: "\(abbr)Attendance", bundle: nil).instantiateInitialViewController()
            case "personal":
                vc = UIStoryboard(name: "\(abbr)Personal", bundle: nil).instantiateInitialViewController()
            case "sign":
                vc = UIStoryboard(name: "\(abbr)Sign", bundle: nil).instantiateInitialViewController()
            case "statistics":
                vc = UIStoryboard(name: "\(abbr)Statistics", bundle: nil).instantiateInitialViewController()
            default:
                return
            }
            vc!.tabBarItem = item
            vcArray.append(vc!)
        }
        viewControllers = vcArray
    }
}