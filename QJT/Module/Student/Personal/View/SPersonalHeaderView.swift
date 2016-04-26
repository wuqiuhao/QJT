//
//  SPersonalHeaderView.swift
//  QJT
//
//  Created by LZQ on 16/4/26.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SPersonalHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        createHeaderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension SPersonalHeaderView {
    
    func createHeaderView() {
        
        let avatarImageView = UIImageView()
        avatarImageView.bounds = CGRectMake(0, 0, 70, 70)
        avatarImageView.center = self.center
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        avatarImageView.layer.masksToBounds = true
        avatarImageView.image = UIImage(named: "SPersonal_avatar")
        self.addSubview(avatarImageView)
        
    }
    
}