//
//  SPersonalHeaderView.swift
//  QJT
//
//  Created by LZQ on 16/4/26.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

import UIKit

class TableViewHeaderView: UIView {
    var delegate : TableViewHeaderViewDelegate?
    var dataSource: TableViewHeaderViewDataSource?
//    var visualEffectView: UIVisualEffectView!
    
    private var backgroundImageView: UIImageView? {
        didSet {
            guard backgroundImageView != nil else {
                return
            }
            addSubview(backgroundImageView!)
            backgroundImageView?.clipsToBounds = true
            sendSubviewToBack(backgroundImageView!)
        }
    }
    
    var backgroundImage: UIImage? {
        didSet {
            backgroundImageView = UIImageView(frame: self.frame)
            backgroundImageView!.image = backgroundImage?.applyLightEffect()
            backgroundImageView!.contentMode = UIViewContentMode.ScaleAspectFill
        }
    }
    
    private var contentView = TableHeaderContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: - private Method
extension TableViewHeaderView {
    func layoutHeaderView(offset: CGPoint)  {
        delegate?.tableViewDuringScrollingAnnimation(contentView,offset: offset)
        var rect = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, bounds.size.height)
        rect.origin.y += offset.y
        rect.size.height -= offset.y
        backgroundImageView?.frame = rect
        contentView.frame = rect
    }
    
    func reloadData() {
        contentView.removeFromSuperview()
        contentView = dataSource?.tableHeaderView(self) as! TableHeaderContentView
        contentView.clipsToBounds = true
        addSubview(contentView)
    }
}

protocol TableViewHeaderViewDelegate {
    func tableViewDuringScrollingAnnimation(contentView: TableHeaderContentView,offset: CGPoint)
}
protocol TableViewHeaderViewDataSource {
    func tableHeaderView(tableHeaderView: UIView) -> UIView
}

class TableHeaderContentView: UIView {
    func layoutContentSubView(offset: CGPoint) {
    }
}
