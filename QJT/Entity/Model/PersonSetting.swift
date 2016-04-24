//
//  PersonSetting.swift
//  QJT
//
//  Created by LZQ on 16/4/17.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

class PersonSetting: NSObject,Mappable {
    
    // 学号、工号
    var userID: String
    // 姓名
    var userName: String
    // 联系方式
    var phoneNum: String
    // 用户类型
    var userType: Int
    // 头像编号
    var portraitID: Int
    // 菜单列表
    var appMenus: [AppMenu]
    
    override init() {
        userID = ""
        userName = ""
        userType = 0
        phoneNum = ""
        portraitID = 0
        appMenus = [AppMenu]()
    }
    
    required init?(_ map: Map) {
        userID = ""
        userName = ""
        userType = 0
        phoneNum = ""
        portraitID = 0
        appMenus = [AppMenu]()
    }
    
    func mapping(map: Map) { 
        userID      <- map["userID"]
        userName    <- map["userName"]
        phoneNum    <- map["phoneNum"]
        userType    <- map["userType"]
        portraitID  <- map["portraitID"]
        appMenus    <- map["appMenus"]
    }
    
}