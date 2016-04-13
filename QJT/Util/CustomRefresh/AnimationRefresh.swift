//
//  AnimationRefresh.swift
//  iDoc
//
//  Created by Broccoli on 15/9/7.
//  Copyright (c) 2015年 iue. All rights reserved.
//

import UIKit

class AnimationRefresh: MJRefreshHeader {
    
    var animationView: NVActivityIndicatorView?
    override var pullingPercent: CGFloat {
        set {
            super.pullingPercent = newValue
            changePullingPercent(newValue)
        }
        get {
            return super.pullingPercent
        }
    }
   override var state: MJRefreshState {
        set {
            let oldState = self.state
            if newValue.rawValue == oldState.rawValue {
                return
            }
            super.state = newValue
            checkState(newValue)
        }
        get {
            return super.state
        }
    }
    override func prepare() {
        super.prepare()
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: self.mj_w * 0.5, y: self.mj_h * 0.5, width: 50, height: 50),
            type: .BallScaleMultiple)
        activityIndicatorView.color = UIColor.lightGrayColor()
//        activityIndicatorView.backgroundColor = UIColor.redColor()
        self.addSubview(activityIndicatorView)
        animationView = activityIndicatorView
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        animationView!.center = CGPoint(x: self.mj_w * 0.5, y: self.mj_h * 0.5)
    }
    func changePullingPercent(percent: CGFloat) {
        
    }
    func checkState(state: MJRefreshState) {
       
        switch state.rawValue {
        case MJRefreshState.Refreshing.rawValue:
            self.animationView!.startAnimation()
        default:
            break
        }
    }
    override func scrollViewContentOffsetDidChange(change: [NSObject : AnyObject]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    override func scrollViewContentSizeDidChange(change: [NSObject : AnyObject]!) {
        super.scrollViewContentSizeDidChange(change)
    }
    override func scrollViewPanStateDidChange(change: [NSObject : AnyObject]!) {
        super.scrollViewPanStateDidChange(change)
    }
}
