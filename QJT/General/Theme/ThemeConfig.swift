//
//  ThemeConfig.swift
//  QJT
//
//  Created by wuqiuhao on 16/4/26.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

class ThemeConfig {
    class func configUI() {
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.qjtNavgationBarTitleColor()]
        UINavigationBar.appearance().tintColor = UIColor.qjtTintColor()
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName : UIFont.systemFontOfSize(16.0), NSForegroundColorAttributeName: UIColor.qjtTintColor()], forState: UIControlState.Normal)
        UIBarButtonItem.appearance().tintColor = UIColor.qjtTintColor()
    }
}
