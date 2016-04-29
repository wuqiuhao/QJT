//
//  UIButton_extension.swift
//  QJT
//
//  Created by wuqiuhao on 16/4/29.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

extension UIButton {
    func setImageColor(color: UIColor) {
        let image = imageForState(.Normal)!.imageWithColor(color)
        setImage(image, forState: .Normal)
    }
}