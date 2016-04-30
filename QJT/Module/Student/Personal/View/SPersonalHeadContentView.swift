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

    var avatarImg: UIImageView!
    
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
        avatarImg = UIImageView()
        avatarImg.image = UIImage(named: "SPersonal_avatar")
        self.addSubview(avatarImg)
    }
    
    func configConstraintes() {
        
        avatarImg.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        
    }
}