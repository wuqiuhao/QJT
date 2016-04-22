//
//  NSString_extension.swift
//  QJT
//
//  Created by LZQ on 16/4/21.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

extension NSString {
    
    /**
     获得字符串所在Label的尺寸  不主动调用 配合 UILabel 的 extension 使用
     
     - parameter font:    字体大小
     - parameter size:    size
     - parameter options: options  // 可选值 默认是 NSStringDrawingOptions.UsesLineFragmentOrigin 可以不传
     
     - returns: Label的size
     */
    func textSizeOfFont(font: UIFont, size: CGSize, _ options: NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin) -> CGSize {
        var lblSize: CGSize?
        let rec = self.boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName : font], context: nil)
        lblSize = CGSize(width: ceil(rec.size.width), height: ceil(rec.size.height))
        
        return lblSize!
    }
}