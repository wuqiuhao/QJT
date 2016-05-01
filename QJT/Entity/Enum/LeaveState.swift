//
//  LeaveState.swift
//  QJT
//
//  Created by LZQ on 16/4/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

enum LeaveState:Int, BaseType {
    case Unknown
    case Verify
    case Success
    case Failed
    
    
    func toString() -> String {
        switch self {
        case .Unknown:
            return "Unknown"
        case .Verify:
            return "Verify"
        case .Success:
            return "Success"
        case .Failed:
            return "Failed"
        }
    }
    
    func toInt() -> Int {
        return self.rawValue
    }
    
    func fromString(value: String) -> Int {
        switch value {
        case "Unknown":
            return LeaveState.Unknown.rawValue
        case  "Verify":
            return LeaveState.Verify.rawValue
        case "Success":
            return LeaveState.Success.rawValue
        case "Failed":
            return LeaveState.Failed.rawValue
        default:
            return LeaveState.Unknown.rawValue
        }
    }
    
    func toDescription() -> String {
        switch self {
        case .Unknown:
            return "未知"
        case .Verify:
            return "审核中"
        case .Success:
            return "成功"
        case .Failed:
            return "失败"
        }
    }
    
}