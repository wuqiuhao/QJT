//
//  UIColor_extension.swift
//  QJT
//
//  Created by LZQ on 16/4/5.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

extension UIColor {
    class func qjtTintColor() -> UIColor {
        return UIColor(red: 50/255.0, green: 167/255.0, blue: 255/255.0, alpha: 1.0)
    }
    
    class func qjtMessageColor() -> UIColor {
        return UIColor(red: 64/255.0, green: 64/255.0, blue: 64/255.0, alpha: 1.0)
    }
    
    
    class func qjtNavgationBarTitleColor() -> UIColor {
        return UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 1.0)
    }
    
    class func qjtViewBackgroundColor() -> UIColor {
        return UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
    }
    
    class func qjtInputTextColor() -> UIColor {
        return UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1.0)
    }
    
    class func qjtBorderColor() -> UIColor {
        return UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }
    
    class func avatarBackgroundColor() -> UIColor {
        return UIColor(red: 50/255.0, green: 167/255.0, blue: 255/255.0, alpha: 0.3)
    }
    
    class func leftBubbleTintColor() -> UIColor {
        return UIColor(white: 231 / 255.0, alpha: 1.0)
    }
    
    class func rightBubbleTintColor() -> UIColor {
        return UIColor.qjtTintColor()
    }
    
    class func leftWaveColor() -> UIColor {
        return UIColor.darkGrayColor().colorWithAlphaComponent(0.2)
    }
    
    class func rightWaveColor() -> UIColor {
        return UIColor(red:0.176,  green:0.537,  blue:0.878, alpha:1)
    }
    
    class func skillMasterColor() -> UIColor {
        return qjtTintColor()
    }
    
    class func skillLearningColor() -> UIColor {
        return UIColor(red:0.49, green:0.83, blue:0.13, alpha:1)
    }
    
    class func messageToolBarColor() -> UIColor {
        return UIColor(red:0.557, green:0.557, blue:0.576, alpha:1)
    }
    
    class func messageToolBarHighlightColor() -> UIColor {
        return UIColor.qjtTintColor()
    }
    
    class func messageToolBarNormalColor() -> UIColor {
        return UIColor.lightGrayColor()
    }
    
    class func qjtDisabledColor() -> UIColor {
        return UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)
    }
    
    class func qjtGrayColor() -> UIColor {
        return UIColor(red: 142.0/255.0, green: 142.0/255.0, blue: 147.0/255.0, alpha: 1.0)
    }
    
    class func qjtBackgroundColor() -> UIColor {
        return UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
    }
    
    class func qjtCellSeparatorColor() -> UIColor {
        return UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
    }
    
    class func qjtCellAccessoryImageViewTintColor() -> UIColor {
        return UIColor.lightGrayColor()
    }
    
    class func qjtIconImageViewTintColor() -> UIColor {
        return qjtCellAccessoryImageViewTintColor()
    }
    
    // 反色
    var yep_inverseColor: UIColor {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return UIColor(red: 1 - red, green: 1 - green, blue: 1 - blue, alpha: alpha)
    }
    
    // 黑白色
    var yep_binaryColor: UIColor {
        
        var white: CGFloat = 0
        getWhite(&white, alpha: nil)
        
        return white > 0.92 ? UIColor.blackColor() : UIColor.whiteColor()
    }
    
    var yep_profilePrettyColor: UIColor {
        //return yep_inverseColor
        return yep_binaryColor
    }
}
