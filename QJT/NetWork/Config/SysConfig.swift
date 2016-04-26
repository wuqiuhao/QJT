//
//  SysConfig.swift
//  QJT
//
//  Created by wuqiuhao on 16/3/29.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

class  SysConfig {
    static let serverIp = "127.0.0.1"
    static let serverPort = "8080"
    
    static func getServerURL()-> String {
        return "http://\(serverIp):\(serverPort)/"
    }
    
    static func getPicURL()-> String {
        return getServerURL() + "picture/getPic"
    }
}