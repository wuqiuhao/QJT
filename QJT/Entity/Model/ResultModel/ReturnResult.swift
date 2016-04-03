//
//  BaseModel.swift
//  QJT
//
//  Created by wuqiuhao on 16/3/31.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

class ReturnResult<T: Mappable,E: Mappable>: Mappable {
    var isFailed: Bool?
    var errorMsg: String?
    var model: T?
    var list: [E]?
    
    init(){}
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        isFailed <- map["failed"]
        errorMsg <- map["errorMsg"]
        model <- map["model"]
        list <- map["list"]
    }
}
