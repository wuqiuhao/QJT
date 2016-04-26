//
//  EmptyModel.swift
//  QJT
//
//  Created by YC on 16/4/26.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

class EmptyModel: Mappable {
    var isFailed: Bool?
    
    init(){}
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        isFailed <- map["failed"]
    }
}