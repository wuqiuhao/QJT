//
//  HLable.swift
//  iDoc
//
//  Created by wuqiuhao on 16/3/30.
//  Copyright © 2016年 iue. All rights reserved.
//

import UIKit

enum VerticalAlignment {
    case Top
    case Middle
    case Bottom
}

class HLable: UILabel {
    
    var isCourseSelected: Bool = false
    
    override init(frame: CGRect) {
        self.verticalAlignment = .Middle
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.verticalAlignment = .Middle
        super.init(coder: aDecoder)
    }
    
    var verticalAlignment: VerticalAlignment {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var textRect = super.textRectForBounds(bounds, limitedToNumberOfLines: numberOfLines)
        switch self.verticalAlignment {
        case .Top:
            textRect.origin.y = bounds.origin.y
        case .Bottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height
        case .Middle:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0
            textRect.origin.x = 3
        }
        return textRect
    }
    
    override func drawTextInRect(rect: CGRect) {
        let actualRect = self.textRectForBounds(rect, limitedToNumberOfLines: numberOfLines)
        super.drawTextInRect(actualRect)
    }
}
