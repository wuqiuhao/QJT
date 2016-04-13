//
//  Method.swift
//  QJT
//
//  Created by wuqiuhao on 16/3/29.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

var LoginService = [
    "login_studentLogin"
]

var TestService = [
    "test"
]

class Methods {
    // 数据测试接口
    static let test = "test"
    // 学生登录
    static let login_studentLogin = "login_studentLogin"
    
    
    class func getServiceMethod() -> [String:AnyObject] {
        let serviceMethods =
            ["LoginController":LoginService,
             "TestController":TestService]
        return serviceMethods
    }
}
