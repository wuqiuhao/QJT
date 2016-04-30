//
//  SPersonalLeaveNoteCell.swift
//  QJT
//
//  Created by LZQ on 16/4/28.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SPersonalLeaveNoteCell: UITableViewCell {

    
    @IBOutlet weak var beginLbl: UILabel!
    @IBOutlet weak var endLbl: UILabel!
    @IBOutlet weak var teacherLbl: UILabel!
    @IBOutlet weak var stateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        //指定直线样式
        CGContextSetLineCap(context, CGLineCap.Round)
        //直线宽度
        CGContextSetLineWidth(context,2)
        //设置颜色
        CGContextSetRGBStrokeColor(context,0/255, 0/255, 0/255, 1.0)
        //开始绘制
        CGContextBeginPath(context)
        //画笔移动到点(31,170)
        CGContextMoveToPoint(context,100, rect.height / 2 )
        //下一点
        CGContextAddLineToPoint(context,UIScreen.mainScreen().bounds.width - 110, rect.height / 2)
        //绘制完成
        //CGContextStrokePath(context)
        CGContextMoveToPoint(context, UIScreen.mainScreen().bounds.width - 120, rect.height / 2 - 5)
        CGContextAddLineToPoint(context,UIScreen.mainScreen().bounds.width - 110, rect.height / 2)
        //CGContextStrokePath(context)
        CGContextMoveToPoint(context, UIScreen.mainScreen().bounds.width - 120, rect.height / 2 + 5)
        CGContextAddLineToPoint(context, UIScreen.mainScreen().bounds.width - 110, rect.height / 2)
        CGContextStrokePath(context)
        
        
    }

}
