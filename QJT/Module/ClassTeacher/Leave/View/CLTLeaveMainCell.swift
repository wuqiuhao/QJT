//
//  CLTLeaveMainCell.swift
//  QJT
//
//  Created by LZQ on 16/4/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class CLTLeaveMainCell: UITableViewCell {

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
        
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineWidth(context,1.0 / UIScreen.mainScreen().scale)
        CGContextSetAllowsAntialiasing(context, false)
        CGContextSetRGBStrokeColor(context,0/255, 0/255, 0/255, 1.0)
        CGContextBeginPath(context)
        
        CGContextMoveToPoint(context,100, rect.height / 2 )
        CGContextAddLineToPoint(context,UIScreen.mainScreen().bounds.width - 110, rect.height / 2)
        
        CGContextMoveToPoint(context, UIScreen.mainScreen().bounds.width - 120, rect.height / 2 - 5)
        CGContextAddLineToPoint(context,UIScreen.mainScreen().bounds.width - 110, rect.height / 2)
        
        CGContextMoveToPoint(context, UIScreen.mainScreen().bounds.width - 120, rect.height / 2 + 5)
        CGContextAddLineToPoint(context, UIScreen.mainScreen().bounds.width - 110, rect.height / 2)
        
        CGContextStrokePath(context)
        
    }

}