//
//  CourseView.swift
//  QJT
//
//  Created by LZQ on 16/4/23.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class CourseView: UIView {
    
    var row: Int = 6
    var col: Int = 12
    var backgroundImageView: UIImageView!
    let weekExcelWidth: CGFloat = (UIScreen.mainScreen().bounds.width - 30) / 5
    let partExcelHeight: CGFloat = (UIScreen.mainScreen().bounds.height - 64 - 30) / 11
    let borderColor = UIColor.whiteColor().CGColor
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundImageView = UIImageView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension CourseView {
    
    func configUI() {
        
        backgroundImageView.image = UIImage(named: "course_background")
        self.addSubview(backgroundImageView)
        for i in 0 ..< row {
            for j in 0 ..< col {
                
                //第一格
                if i==0 && j==0 {
                    let emptyUtil = UILabel()
                    emptyUtil.frame = CGRectMake(0, 0, 30, 30)
                    emptyUtil.layer.borderWidth = 1.0 / UIScreen.mainScreen().scale
                    emptyUtil.layer.borderColor =  borderColor
                    self.addSubview(emptyUtil)
                }
                //第一列（节数）
               else if i == 0 && j != 0 {
                    let partLbl = UILabel()
                    let partOffsetY = partExcelHeight * CGFloat(j - 1) + 30
                    partLbl.frame = CGRectMake(0, partOffsetY, 30, partExcelHeight)
                    partLbl.layer.borderWidth = 1.0 / UIScreen.mainScreen().scale
                    partLbl.layer.borderColor = borderColor
                    partLbl.text = "\(j)"
                    partLbl.textAlignment = .Center
                    partLbl.font = UIFont.systemFontOfSize(14)
                    partLbl.textColor = UIColor.qjtTintColor()
                    self.addSubview(partLbl)
                }
                //第一行（星期）
                else if j == 0 && i != 0 {
                    let weekLbl = UILabel()
                    let weekOffsetX = weekExcelWidth * CGFloat(i - 1) + 30
                    weekLbl.frame = CGRectMake(weekOffsetX, 0, weekExcelWidth, 30)
                    weekLbl.layer.borderWidth = 1.0 / UIScreen.mainScreen().scale
                    weekLbl.layer.borderColor =  borderColor
                    weekLbl.text = calculateWeek(i)
                    weekLbl.textAlignment = .Center
                    weekLbl.font = UIFont.systemFontOfSize(14)
                    weekLbl.textColor = UIColor.qjtTintColor()
                    self.addSubview(weekLbl)
                }
                //课程格子边框
                else {
                    
                    let vertLineView = UIView()
                    let vertLineOffsetX = 30 + weekExcelWidth * CGFloat(i)
                    let vertLineOffsetY = 30 + partExcelHeight * CGFloat(j) - 4
                    vertLineView.frame = CGRectMake(vertLineOffsetX, vertLineOffsetY, 1.0 / UIScreen.mainScreen().scale, 8)
                    let horiLineView = UIView()
                    let horiLineOffsetX = 30 + weekExcelWidth * CGFloat(i) - 4
                    let horiLineOffsetY = 30 + partExcelHeight * CGFloat(j)
                    horiLineView.frame = CGRectMake(horiLineOffsetX, horiLineOffsetY, 8, 1.0 / UIScreen.mainScreen().scale)
                    
                    vertLineView.backgroundColor = UIColor.qjtTintColor()
                    horiLineView.backgroundColor = UIColor.qjtTintColor()
                    self.addSubview(vertLineView)
                    self.addSubview(horiLineView)
                    
                    
                }
            }
        }
        
    }
    
    func calculateWeek(number: Int) -> String {
        switch number {
        case 1:
            return "周一"
        case 2:
            return "周二"
        case 3:
            return "周三"
        case 4:
            return "周四"
        case 5:
            return "周五"
        default:
            return ""
        }
    }
    
}
