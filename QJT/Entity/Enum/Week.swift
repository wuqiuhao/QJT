//
//  Week.swift
//  QJT
//
//  Created by LZQ on 16/4/20.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

enum Week:Int,BaseType {
    case Unknown
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
    
    func toString() -> String {
        switch self {
        case .Unknown:
            return "未知"
        case .Monday:
            return "周一"
        case .Tuesday:
            return "周二"
        case .Wednesday:
            return "周三"
        case .Thursday:
            return "周四"
        case .Friday:
            return "周五"
        case .Saturday:
            return "周六"
        case .Sunday:
            return "周日"
        }
    }
    
    func toInt() -> Int {
        return self.rawValue
    }
    
    func fromString(value: String) -> Int {
        switch value {
        case "Unknown":
            return Week.Unknown.rawValue
        case "Monday":
            return Week.Monday.rawValue
        case "Tuesday":
            return Week.Tuesday.rawValue
        case "Wednesday":
            return Week.Wednesday.rawValue
        case "Thursday":
            return Week.Thursday.rawValue
        case "Friday":
            return Week.Friday.rawValue
        case "Saturday":
            return Week.Saturday.rawValue
        case "Sunday":
            return Week.Sunday.rawValue
        default:
            return Week.Unknown.rawValue
        }
    }
    
}