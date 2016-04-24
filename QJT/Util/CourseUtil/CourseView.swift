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
    var col: Int = 10
    var courseExcelWidth: CGFloat = (UIScreen.mainScreen().bounds.height - 64 - 30) / 10
    var backgroundImageView: UIImageView!
    
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
            //第一行（星期）
            
            
            
            for j in 0 ..< col {
                
                //第一格
                if i==0 && j==0 {
                    let emptyUtil = UIImageView()
                    emptyUtil.frame = CGRectMake(0, 0, 30, 30)
                    self.addSubview(emptyUtil)
                }
                //第一列（节数）
                if i == 0 && j != 0{
                    let partImageView = UIImageView()
                    let partOffsetY = courseExcelWidth * CGFloat(j - 1) + 30
                    partImageView.frame = CGRectMake(0, partOffsetY, 30, courseExcelWidth)
                    partImageView.backgroundColor = UIColor.redColor()
                }
                //第一行（星期）
                if j == 0 && i != 0 {
                    let weekImageView = UIImageView()
                    let weekOffsetX = courseExcelWidth * CGFloat(i - 1) + 30
                    weekImageView.frame = CGRectMake(weekOffsetX, 0, courseExcelWidth, 30)
                    weekImageView.backgroundColor = UIColor.blueColor()
                    
                }
            }
        }
        
    }
    
}
