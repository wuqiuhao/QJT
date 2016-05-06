//
//  SysConfig.swift
//  QJT
//
//  Created by wuqiuhao on 16/3/29.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

class  SysConfig {
    static let serverIp = "115.29.48.216"
    //static let serverIp = "172.23.125.250"
    static let serverPort = "8080"
    
    static func getServerURL()-> String {
        return "http://\(serverIp):\(serverPort)/qjt/"
    }
    
    static func getPicURL()-> String {
        return getServerURL() + "picture/getPic"
    }
}