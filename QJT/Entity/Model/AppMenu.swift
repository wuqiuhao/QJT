//
//  AppMenu.swift
//  QJT
//
//  Created by LZQ on 16/4/20.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

class AppMenu: NSObject,NSCoding,Mappable {
    
    // 菜单名
    var menuName: String
    // 菜单唯一值
    var uniqueCode: String
    // 菜单自定义参数
    var menuParameter: String
    
    override init() {
        menuName = ""
        uniqueCode = ""
        menuParameter = ""
    }
    
    required init?(_ map: Map) {
        menuName = ""
        uniqueCode = ""
        menuParameter = ""
    }
    
    func mapping(map: Map) {
        menuName        <- map["menuName"]
        uniqueCode      <- map["uniqueCode"]
        menuParameter   <- map["menuParameter"]
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(menuName, forKey: "menuName")
        aCoder.encodeObject(uniqueCode, forKey: "uniqueCode")
        aCoder.encodeObject(menuParameter, forKey: "menuParameter")
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        menuName = aDecoder.decodeObjectForKey("menuName") as! String
        uniqueCode = aDecoder.decodeObjectForKey("uniqueCode") as! String
        menuParameter = aDecoder.decodeObjectForKey("menuParameter") as! String
    }
}