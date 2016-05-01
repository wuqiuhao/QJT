//
//  SPersonalHeadContentView.swift
//  QJT
//
//  Created by LZQ on 16/4/26.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit
import SnapKit

class SPersonalHeadContentView: TableHeaderContentView {

    var avatarView: UIView!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutContentSubView(offset: CGPoint) {
        
    }

}

// MARK: - private Method
extension SPersonalHeadContentView {
    
    func configUI() {
        avatarView = UIView()
        avatarView.backgroundColor = UIColor.whiteColor()
        imageView = UIImageView()
        avatarView.layer.cornerRadius = 40
        imageView.layer.cornerRadius = 37
        imageView.clipsToBounds = true
        avatarView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.image = UIImage(named: "SPersonal_avatar")
        avatarView.addSubview(imageView)
        self.addSubview(avatarView)
    }
    
    func configConstraintes() {
        imageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(avatarView)
            make.centerY.equalTo(avatarView)
            make.width.equalTo(74)
            make.height.equalTo(74)
        }
        avatarView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
    }
}