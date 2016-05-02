//
//  Speciality.swift
//  QJT
//
//  Created by LZQ on 16/5/2.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

class Speciality: Mappable{
    
    var specialityID: Int
    var name: String
    var brief: String
    
    init() {
        specialityID = 0
        name = ""
        brief = ""
    }
    
    required init?(_ map: Map) {
        specialityID = 0
        name = ""
        brief = ""
    }
    
    func mapping(map: Map) {
        specialityID        <- map["specialityID"]
        name                <- map["name"]
        brief               <- map["brief"]
    }
}