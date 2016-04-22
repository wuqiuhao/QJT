//
//  UILabel_extension.swift
//  QJT
//
//  Created by LZQ on 16/4/21.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

extension UILabel {
    
    /**
     根据 text 文本信息 获取Label的size
     
     - parameter string: 文本信息
     - parameter font:   字体大小
     - parameter width:  最大宽度
     
     - returns: size
     */
    class func textSize(string: String, font: UIFont, width: CGFloat) -> CGSize {
        if string.characters.count == 0 {
            return CGSizeZero
        }
        let maxSize = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let NSStr = string as NSString
        return NSStr.textSizeOfFont(font, size: maxSize)
    }
    
}