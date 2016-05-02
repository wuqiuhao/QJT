//
//  Class.swift
//  QJT
//
//  Created by LZQ on 16/5/2.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

class Class: Mappable {
    var classID: Int
    var className: String
    var departmentID: Int
    var schoolYear: Int
    
    init() {
        classID = 0
        className = ""
        departmentID = 0
        schoolYear = 0
    }
    
    required init?(_ map: Map) {
        classID = 0
        className = ""
        departmentID = 0
        schoolYear = 0
    }
    
    func mapping(map: Map) {
        classID         <- map["classID"]
        className       <- map["className"]
        departmentID    <- map["departmentID"]
        schoolYear      <- map["schoolYear"]
    }
    
}