//
//  LeaveDetail.swift
//  QJT
//
//  Created by LZQ on 16/5/1.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

class LeaveDetail: Mappable {
    var leaveDetailID: Int
    var leaveID: Int
    var courseClassUniqueID: Int
    var address: String
    var courseName: String
    
    init() {
        leaveDetailID = 0
        leaveID = 0
        courseClassUniqueID = 0
        address = ""
        courseName = ""
    }
    
    required init?(_ map: Map) {
        leaveDetailID = 0
        leaveID = 0
        courseClassUniqueID = 0
        address = ""
        courseName = ""
    }
    
   func mapping(map: Map) {
        leaveDetailID       <- map["leaveDetailID"]
        leaveID             <- map["leaveID"]
        courseClassUniqueID <- map["courseClassUniqueID"]
        address             <- map["address"]
        courseName          <- map["courseName"]
    }
}