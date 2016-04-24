//
//  LeaveCourseCollectionCell.swift
//  QJT
//
//  Created by LZQ on 16/4/17.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class LeaveCourseCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var numLbl: UILabel!
    
    override func awakeFromNib() {
        self.layer.borderWidth = 1 / UIScreen.mainScreen().scale
        self.layer.borderColor = UIColor.blackColor().CGColor


    }
    
}
