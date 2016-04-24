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
    let partExcelHeight: CGFloat = (UIScreen.mainScreen().bounds.height - 64 - 30) / 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCourseBackground()
        
        
        let model = CourseClass()
        model.address = "B-301"
        model.courseClassID = 104
        model.week = Week.Tuesday
        model.fromSection = 1
        model.durationSection = 2
        model.courseName = "C语言设计"
        courseArrData.append(model)
        
        let model1 = CourseClass()
        model1.address = "B-301"
        model1.courseClassID = 104
        model1.week = Week.Friday
        model1.fromSection = 7
        model1.durationSection = 3
        model1.courseName = "C语言设计"
        courseArrData.append(model1)
        
        configCourseExcel()
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
            
            let offsetX = 30 + CGFloat(course.week.toInt() - 1) * weekExcelWidth + 1
            let offsetY = 30 + CGFloat(course.fromSection - 1) * partExcelHeight + 1
            let courseLbl = HLable()
            courseLbl.verticalAlignment = .Middle
            courseLbl.frame = CGRectMake(offsetX, offsetY, weekExcelWidth - 2, partExcelHeight * CGFloat(course.durationSection) - 2)
            courseLbl.text = course.courseName + "\n" + course.address
            courseLbl.backgroundColor = UIColor.redColor()
            courseLbl.numberOfLines = 0
            courseLbl.font = UIFont.systemFontOfSize(14)
            courseLbl.layer.cornerRadius = 4
            courseLbl.layer.masksToBounds = true
            courseLbl.textColor = UIColor.whiteColor()
            courseView.addSubview(courseLbl)
            
        }
        
    }
    
}