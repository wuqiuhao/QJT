//
//  LeaveCourseViewController.swift
//  QJT
//
//  Created by LZQ on 16/4/23.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class LeaveCourseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.automaticallyAdjustsScrollViewInsets = false
        let courseView = CourseView(frame: CGRect(x: 0, y: 64, width: 375, height: 667 - 64))
        self.view.addSubview(courseView)
        
        // Do any additional setup after loading the view.
    }

}
