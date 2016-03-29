//
//  Method.swift
//  QJT
//
//  Created by wuqiuhao on 16/3/29.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

var LoginService: [String] = [
    "login_studentLogin"
]

class Methods {
    // 学生登录
    static let login_studentLogin = "login_studentLogin"
    
    class func getServiceMethod() -> [String:AnyObject] {
        let serviceMethods =
            ["LoginController":LoginService]
        return serviceMethods
    }
}
