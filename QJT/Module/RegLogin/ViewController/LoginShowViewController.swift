//
//  LoginShowViewController.swift
//  QJT
//
//  Created by LZQ on 16/3/31.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class LoginShowViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageCtrl: UIPageControl!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!

    private var isFirstAppear = true
    
    private var steps = [UIViewController]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        if isFirstAppear {
            scrollView.alpha = 0
            pageCtrl.alpha = 0
            registerBtn.alpha = 0
            loginBtn.alpha = 0
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if isFirstAppear {
            UIView.animateWithDuration(1, delay: 0.5, options: .CurveEaseInOut, animations: { [weak self] in
                self?.scrollView.alpha = 1
                self?.pageCtrl.alpha = 1
                self?.registerBtn.alpha = 1
                self?.loginBtn.alpha = 1
                }, completion: { _ in })
        }
        
        isFirstAppear = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LoginShowViewController {
    
    private func makeUI() {
        
        let stepA = stepGenius()
        let stepB = stepMatch()
        let stepC = stepMeet()
        
        steps = [stepA, stepB, stepC]
        
        pageCtrl.numberOfPages = steps.count
        pageCtrl.pageIndicatorTintColor = UIColor.qjtBorderColor()
        pageCtrl.currentPageIndicatorTintColor = UIColor.qjtTintColor()
        
        registerBtn.setTitle("重置", forState: .Normal)
        loginBtn.setTitle("登陆", forState: .Normal)
        
        registerBtn.backgroundColor = UIColor.qjtTintColor()
        loginBtn.setTitleColor(UIColor.qjtInputTextColor(), forState: .Normal)
        
        registerBtn.addTarget(self, action: #selector(LoginShowViewController.registerBtnClicked), forControlEvents: UIControlEvents.TouchUpInside)
        loginBtn.addTarget(self, action: #selector(LoginShowViewController.loginBtnClicked), forControlEvents: UIControlEvents.TouchUpInside)
        
        loginBtn.layer.borderColor = UIColor.qjtCellSeparatorColor().CGColor
        loginBtn.layer.borderWidth = 1/UIScreen.mainScreen().scale
        
        let viewsDictionary = [
            "view": view,
            "stepA": stepA.view,
            "stepB": stepB.view,
            "stepC": stepC.view,
            ]
        
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[stepA(==view)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        
        NSLayoutConstraint.activateConstraints(vConstraints)
        
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[stepA(==view)][stepB(==view)][stepC(==view)]|", options: [.AlignAllBottom, .AlignAllTop], metrics: nil, views: viewsDictionary)
        
        NSLayoutConstraint.activateConstraints(hConstraints)
    }

    
    private func stepGenius() -> LoginGeniusViewController {
        let step = storyboard!.instantiateViewControllerWithIdentifier("LoginGeniusViewController") as! LoginGeniusViewController
        
        step.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(step.view)
        
        addChildViewController(step)
        step.didMoveToParentViewController(self)
        
        return step
    }
    
    private func stepMatch() -> LoginMatchViewController {
        let step = storyboard!.instantiateViewControllerWithIdentifier("LoginMatchViewController") as! LoginMatchViewController
        
        step.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(step.view)
        
        addChildViewController(step)
        step.didMoveToParentViewController(self)
        
        return step
    }
    
    private func stepMeet() -> LoginMeetViewController {
        let step = storyboard!.instantiateViewControllerWithIdentifier("LoginMeetViewController") as! LoginMeetViewController
        
        step.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(step.view)
        
        addChildViewController(step)
        step.didMoveToParentViewController(self)
        
        return step
    }
    
}

// MARK: - UIScrollViewDelegate
extension LoginShowViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let pageWidth = CGRectGetWidth(scrollView.bounds)
        let pageFraction = scrollView.contentOffset.x / pageWidth
        
        let page = Int(round(pageFraction))
        
        pageCtrl.currentPage = page
    }
}

// MARK: - IB Action
extension LoginShowViewController {
    
    func registerBtnClicked() {
       
    }
    
    func loginBtnClicked() {
        
        let vc = UIStoryboard(name: "RegLogin", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
