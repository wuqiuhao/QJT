//
//  PersonSetting.swift
//  QJT
//
//  Created by LZQ on 16/4/17.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

class PersonSetting: NSObject {
    
    var userID: Int
    var userName: String
    var userType: UserType
    
    override init() {
        userID = 0
        userName = ""
        userType = UserType.Unknown
    }
    
}