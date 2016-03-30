//
//  Mappable.swift
//  QJT
//
//  Created by wuqiuhao on 16/3/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import ObjectMapper

public protocol Mappable {
    init?(_ map: Map)
    mutating func mapping(map: Map)
}