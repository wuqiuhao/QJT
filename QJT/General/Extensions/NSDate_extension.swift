//
//  NSDate_extension.swift
//  QJT
//
//  Created by LZQ on 16/4/25.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

import UIKit

extension NSDate {
    
    /**
     将日期时间从 string 转成 date 类型
     
     - parameter dateStr:       string
     - parameter dateformatter: 时间格式
     
     - returns: 转好的 NSDate
     */
    class func dateFromString(dateStr: String, dateformatter: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateformatter
        let date = dateFormatter.dateFromString(dateStr)
        return date!
    }
    
    /**
     根据传入的dateFormatter格式化时间
     
     - parameter dateFormatStr: 例如:"yyyy-MM-dd"
     
     - returns: 格式化后的时间
     */
    func stringForDateFormat(dateFormatStr: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormatStr
        return dateFormatter.stringFromDate(self)
    }
    
    /**
     获取传入时间的星期
     
     - parameter date: 时间
     
     - returns: "星期*"
     */
    func dateToWeek() -> String {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        let weekInt = calendar?.component(NSCalendarUnit.Weekday, fromDate: self)
        switch weekInt! {
        case 0:
            return "星期天"
        case 1:
            return "星期日"
        case 2:
            return "星期一"
        case 3:
            return "星期二"
        case 4:
            return "星期三"
        case 5:
            return "星期四"
        case 6:
            return "星期五"
        case 7:
            return "星期六"
        default:
            return ""
        }
    }
    
    func dateToWeekDay()-> Int {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        let weekDay = calendar?.component(NSCalendarUnit.Weekday, fromDate: self)
        return weekDay!
    }
    
    /**
     时间间隔为半小时
     
     - parameter date: 传入时间
     
     - returns: 返回"HH : mm" mm 为 00 或者 30
     */
    func intervalHalfHour() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "mm"
        let minute = dateFormatter.stringFromDate(self)
        if Int(minute) > 45 {
            dateFormatter.dateFormat = "HH"
            var hour = dateFormatter.stringFromDate(self)
            if hour == "23" {
                hour = "00"
            } else {
                let hourInt = Int(hour)! + 1
                hour = "\(hourInt)"
            }
            return "\(hour):00"
        } else if Int(minute) <= 45 && Int(minute) > 15 {
            dateFormatter.dateFormat = "HH"
            let hour = dateFormatter.stringFromDate(self)
            return "\(hour):30"
        } else {
            dateFormatter.dateFormat = "HH"
            let hour = dateFormatter.stringFromDate(self)
            return "\(hour):00"
        }
    }
    
    
    func getEarlyOrLaterMonthFromDate(date: NSDate, month: Int) -> NSDate{
        
        let comps = NSDateComponents()
        comps.month = month
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let anotherDate = calendar!.dateByAddingComponents(comps, toDate: date, options: NSCalendarOptions.MatchNextTime)
        return anotherDate!
    }
    // GMT时间转成本地时间
    func localDate()-> NSDate {
        let zone = NSTimeZone.systemTimeZone();
        let interval = NSTimeInterval(zone.secondsFromGMTForDate(self))
        let localDate = self.dateByAddingTimeInterval(interval)
        return localDate
    }
}
