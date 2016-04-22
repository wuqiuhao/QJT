//
//  UIViewController_extension.swift
//  QJT
//
//  Created by LZQ on 16/4/21.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

extension UIViewController {
    /**
     取消键盘
     
     - parameter touches: 点击
     - parameter event:   点击事件
     */
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for subView in self.view.subviews {
            if subView.isKindOfClass(UITextField.superclass()!) {
                subView.resignFirstResponder()
            }
            if subView.isKindOfClass(UITextView.superclass()!) {
                subView.resignFirstResponder()
            }
        }
    }
    
    
    func unabledUserInteraction() {
        for subView in self.view.subviews {
            let view = subView
            view.userInteractionEnabled = false
        }
    }
    
    ///  计算属性 用于开启或关闭 “全屏事件禁用”
    // TODO: - 这里直接把 底层 view 的点击事件关闭不行么?
    var userInteractionEnabled: Bool {
        set {
            if newValue == false {
                let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
                UIApplication.sharedApplication().keyWindow?.addSubview(view)
            } else {
                let view = UIApplication.sharedApplication().keyWindow?.subviews.last
                view?.removeFromSuperview()
            }
        }get {
            return false
        }
    }
}