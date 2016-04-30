//
//  LeaveCell.swift
//  QJT
//
//  Created by LZQ on 16/4/25.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class LeaveCell: UITableViewCell {

    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    
    
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
        CGContextSetLineCap(context, CGLineCap.Square)
        //直线宽度
        CGContextSetLineWidth(context,1 / UIScreen.mainScreen().scale)
        //设置颜色
        CGContextSetRGBStrokeColor(context,203/255, 199/255, 204/255, 1.0)
        //开始绘制
        CGContextBeginPath(context)
        //画笔移动到点(31,170)
        CGContextMoveToPoint(context,20, rect.height - 1)
        //下一点
        CGContextAddLineToPoint(context,UIScreen.mainScreen().bounds.width - 15, rect.height - 1)
        //绘制完成
        CGContextStrokePath(context)
        
    }
}
