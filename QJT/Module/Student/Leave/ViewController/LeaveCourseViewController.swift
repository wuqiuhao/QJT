//
//  LeaveCourseViewController.swift
//  QJT
//
//  Created by LZQ on 16/4/23.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class LeaveCourseViewController: UIViewController {

    var courseView: CourseView!
    lazy var courseArrData = [CourseClass]()
    
    let weekExcelWidth: CGFloat = (UIScreen.mainScreen().bounds.width - 30) / 5
    let partExcelHeight: CGFloat = (UIScreen.mainScreen().bounds.height - 64 - 30) / 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCourseBackground()
    }

}

// MARK: - private Method
extension LeaveCourseViewController {
    
    func setupCourseBackground() {
        courseView = CourseView(frame: CGRect(x: 0, y: 64, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 64))
        self.view.addSubview(courseView)
    }
    
    func configCourseExcel() {
        
        for course in courseArrData {
            
            let offsetX = CGFloat(course.fromSection) * partExcelHeight
            let offsetY = 0
            
        }
        
    }
    
}